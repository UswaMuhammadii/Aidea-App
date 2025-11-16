// lib/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customer_app/gen/app_localizations.dart';
import '../../models/user_model.dart';
import '../../services/locale_service.dart';
import '../../utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  final VoidCallback onLogout;

  const ProfileScreen({
    Key? key,
    required this.user,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final l10n = AppLocalizations.of(context)!;
    final localeService = Provider.of<LocaleService>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.phone,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Personal Information Section
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildProfileItem(
                          icon: Icons.person_outline,
                          title: l10n.personalInformation,
                          subtitle: user.name,
                          textColor: textColor,
                          subtitleColor: subtitleColor,
                        ),
                        Divider(height: 1, color: isDark ? Colors.grey.shade700 : Colors.grey.shade200),
                        _buildProfileItem(
                          icon: Icons.location_on_outlined,
                          title: l10n.address,
                          subtitle: user.address,
                          textColor: textColor,
                          subtitleColor: subtitleColor,
                        ),
                      ],
                    ),
                  ),

                  // Settings Section
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Language Switcher
                        _buildLanguageSwitcher(
                          context,
                          localeService,
                          textColor,
                          subtitleColor,
                          l10n,
                        ),
                        Divider(height: 1, color: isDark ? Colors.grey.shade700 : Colors.grey.shade200),
                        _buildSettingItem(
                          icon: Icons.notifications_outlined,
                          title: l10n.notifications,
                          textColor: textColor,
                          trailing: Switch(
                            value: true,
                            onChanged: (value) {},
                            activeColor: AppColors.electricBlue,
                          ),
                        ),
                        Divider(height: 1, color: isDark ? Colors.grey.shade700 : Colors.grey.shade200),
                        _buildSettingItem(
                          icon: Icons.dark_mode_outlined,
                          title: l10n.darkMode,
                          textColor: textColor,
                          trailing: Switch(
                            value: isDark,
                            onChanged: (value) {},
                            activeColor: AppColors.electricBlue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Logout Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.red, Colors.redAccent],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: cardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Text(l10n.logout, style: TextStyle(color: textColor)),
                            content: Text(
                              l10n.areYouSureLogout,
                              style: TextStyle(color: subtitleColor),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  localeService.isArabic ? 'إلغاء' : 'Cancel',
                                  style: TextStyle(color: subtitleColor),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  onLogout();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: Text(l10n.logout),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.logout),
                      label: Text(l10n.logout),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSwitcher(
      BuildContext context,
      LocaleService localeService,
      Color textColor,
      Color subtitleColor,
      AppLocalizations l10n,
      ) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            final dialogBg = isDark ? const Color(0xFF1E293B) : Colors.white;

            return AlertDialog(
              backgroundColor: dialogBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(l10n.language, style: TextStyle(color: textColor)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Text('🇺🇸', style: TextStyle(fontSize: 32)),
                    title: Text('English', style: TextStyle(color: textColor)),
                    trailing: localeService.isEnglish
                        ? const Icon(Icons.check_circle, color: AppColors.electricBlue)
                        : null,
                    onTap: () {
                      localeService.setLocale(const Locale('en'));
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Text('🇸🇦', style: TextStyle(fontSize: 32)),
                    title: Text('العربية', style: TextStyle(color: textColor)),
                    trailing: localeService.isArabic
                        ? const Icon(Icons.check_circle, color: AppColors.electricBlue)
                        : null,
                    onTap: () {
                      localeService.setLocale(const Locale('ar'));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.electricBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.language,
                color: AppColors.electricBlue,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.language,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    localeService.isArabic ? 'العربية' : 'English',
                    style: TextStyle(
                      fontSize: 14,
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: subtitleColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color textColor,
    required Color subtitleColor,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.electricBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.electricBlue, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: subtitleColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required Color textColor,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.electricBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.electricBlue, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}