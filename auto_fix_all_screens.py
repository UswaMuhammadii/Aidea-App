#!/usr/bin/env python3
"""
Complete Flutter Localization Error Fixer
Fixes all 'Undefined name l10n' errors by adding proper imports and initialization
"""

import os
import re
import sys

def fix_l10n_in_file(filepath):
    """Fix l10n issues in a single Dart file"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()

        original_content = content

        # Check if file uses l10n but doesn't have proper setup
        if 'l10n.' in content or "const Text(l10n." in content or "Text(l10n." in content:

            # 1. Add import if missing
            if 'app_localizations.dart' not in content and 'AppLocalizations' not in content[:1000]:
                # Find the last import statement
                import_pattern = r"(import\s+['\"].*?['\"];)"
                imports = list(re.finditer(import_pattern, content))

                if imports:
                    last_import = imports[-1]
                    insert_pos = last_import.end()
                    content = (content[:insert_pos] +
                             "\nimport '../../gen_l10n/app_localizations.dart';" +
                             content[insert_pos:])

            # 2. Add l10n initialization in build methods if missing
            # Pattern: @override Widget build(BuildContext context) {
            build_pattern = r'(@override\s+Widget\s+build\s*\(\s*BuildContext\s+context\s*\)\s*\{)'

            def add_l10n_init(match):
                method_start = match.group(0)
                # Check if l10n is already initialized nearby
                start_pos = match.start()
                next_200_chars = content[start_pos:start_pos + 200]

                if 'final l10n = AppLocalizations.of(context)' in next_200_chars:
                    return method_start  # Already has l10n

                return method_start + '\n    final l10n = AppLocalizations.of(context)!;\n'

            content = re.sub(build_pattern, add_l10n_init, content)

            # 3. Fix const Text(l10n. ...) issues - remove const keyword
            content = re.sub(r'\bconst\s+Text\s*\(\s*l10n\.', 'Text(l10n.', content)
            content = re.sub(r'\bconst\s+\[\s*Text\s*\(\s*l10n\.', '[Text(l10n.', content)

            # 4. Fix standalone l10n usages in const contexts
            # Pattern: const ... l10n.something
            content = re.sub(r'\bconst\s+(.*?)\bl10n\.(\w+)', r'\1l10n.\2', content)

        # Only write if changed
        if content != original_content:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
        return False

    except Exception as e:
        print(f"❌ Error processing {filepath}: {e}")
        return False

def process_directory(directory):
    """Process all Dart files in directory"""
    fixed_count = 0
    total_count = 0

    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart'):
                filepath = os.path.join(root, file)
                total_count += 1

                rel_path = os.path.relpath(filepath, directory)
                print(f"Processing: {rel_path}...", end=" ")

                if fix_l10n_in_file(filepath):
                    print("✅ FIXED")
                    fixed_count += 1
                else:
                    print("⭐ OK")

    return fixed_count, total_count

def main():
    print("╔════════════════════════════════════════════════════════════╗")
    print("║       🔧 Flutter L10N Error Fixer                         ║")
    print("║       Fixes all 'Undefined name l10n' errors              ║")
    print("╚════════════════════════════════════════════════════════════╝")
    print()

    if len(sys.argv) > 1:
        project_path = sys.argv[1]
    else:
        project_path = input("Enter your Flutter project path (or press Enter for current directory): ").strip()
        if not project_path:
            project_path = os.getcwd()

    if not os.path.exists(project_path):
        print("❌ Directory not found!")
        return

    lib_dir = os.path.join(project_path, 'lib')

    if not os.path.exists(lib_dir):
        print("❌ lib directory not found!")
        return

    print(f"\n📂 Scanning: {lib_dir}\n")
    print("─" * 60)

    fixed, total = process_directory(lib_dir)

    print("─" * 60)
    print(f"\n🎉 Completed!")
    print(f"📊 Processed: {total} files")
    print(f"✅ Fixed: {fixed} files")
    print(f"⭐ Already OK: {total - fixed} files")
    print()
    print("🚀 Next steps:")
    print(f"   1. cd {project_path}")
    print("   2. flutter clean")
    print("   3. flutter pub get")
    print("   4. flutter run")
    print()

if __name__ == '__main__':
    main()