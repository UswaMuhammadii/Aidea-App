import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'gen_l10n/app_localizations.dart';
import 'screens/auth/auth_flow_coordinator.dart';
import 'screens/auth/language_selection_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'models/user_model.dart';
import 'services/dummy_data_service.dart';


void main() {
  runApp(const CustomerApp());
}

/// 🌈 Brand Colors & Gradients
class AppColors {
  static const deepPurple = Color(0xFF7C3AED);
  static const electricBlue = Color(0xFF3B82F6);
  static const brightTeal = Color(0xFF14B8A6);
  static const darkPurple = Color(0xFF6D28D9);
  static const lightPurple = Color(0xFF8B5CF6);
  static const darkBlue = Color(0xFF2563EB);
  static const lightBlue = Color(0xFF60A5FA);
  static const darkTeal = Color(0xFF0D9488);
  static const lightTeal = Color(0xFF2DD4BF);
  static const background = Color(0xFFF8FAFC);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF1F5F9);
  static const onSurface = Color(0xFF0F172A);
  static const onSurfaceVariant = Color(0xFF64748B);
  static const darkBackground = Color(0xFF0F172A);
  static const darkSurface = Color(0xFF1E293B);
  static const darkSurfaceVariant = Color(0xFF334155);
  static const darkOnSurface = Color(0xFFF8FAFC);
  static const darkOnSurfaceVariant = Color(0xFFCBD5E1);

  static const primaryGradient = LinearGradient(
    colors: [deepPurple, electricBlue, brightTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const accentGradient = LinearGradient(
    colors: [electricBlue, brightTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// 🌟 Main App Widget with Localization
class CustomerApp extends StatefulWidget {
  const CustomerApp({super.key});

  @override
  State<CustomerApp> createState() => _CustomerAppState();
}

class _CustomerAppState extends State<CustomerApp> {
  Locale _locale = const Locale('en'); // Default locale

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HandyMan',
      debugShowCheckedModeBanner: false,
      
      // Localization delegates
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // Supported locales
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      
      // Current locale
      locale: _locale,
      
      // RTL support
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) {
          return supportedLocales.first;
        }
        
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        
        return supportedLocales.first;
      },
      
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: AuthWrapperWithLanguage(
        currentLocale: _locale,
        onLanguageChanged: _changeLanguage,
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.deepPurple,
        secondary: AppColors.electricBlue,
        surface: AppColors.surface,
        background: AppColors.background,
        onSurface: AppColors.onSurface,
        onBackground: AppColors.onSurface,
      ),
      scaffoldBackgroundColor: AppColors.background,
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.lightPurple,
        secondary: AppColors.lightBlue,
        surface: AppColors.darkSurface,
        background: AppColors.darkBackground,
        onSurface: AppColors.darkOnSurface,
        onBackground: AppColors.darkOnSurface,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
    );
  }
}

/// 🔐 Auth Wrapper with Language Selection
class AuthWrapperWithLanguage extends StatefulWidget {
  final Locale currentLocale;
  final Function(Locale) onLanguageChanged;

  const AuthWrapperWithLanguage({
    super.key,
    required this.currentLocale,
    required this.onLanguageChanged,
  });

  @override
  State<AuthWrapperWithLanguage> createState() => _AuthWrapperWithLanguageState();
}

class _AuthWrapperWithLanguageState extends State<AuthWrapperWithLanguage> {
  bool _languageSelected = false;
  bool _isLoggedIn = false;
  User? _currentUser;

  void _handleLanguageSelection(Locale locale) {
    widget.onLanguageChanged(locale);
    setState(() {
      _languageSelected = true;
    });
  }

  void _handleAuthComplete(User user) {
    // Get localization from the current context
    final l10n = AppLocalizations.of(context);

    if (l10n != null) {
      DummyDataService.addDummyCompletedBookings(user.id, l10n);
    }

    setState(() {
      _isLoggedIn = true;
      _currentUser = user;
    });
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
      _currentUser = null;
      _languageSelected = false; // Reset to language selection on logout
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show language selection if not selected
    if (!_languageSelected) {
      return LanguageSelectionScreen(
        onLanguageSelected: _handleLanguageSelection,
      );
    }

    // Show dashboard if logged in
    if (_isLoggedIn && _currentUser != null) {
      return DashboardScreen(
        user: _currentUser!,
        onLogout: _handleLogout,
      );
    }

    // Show auth flow
    return AuthFlowCoordinator(
      onAuthComplete: _handleAuthComplete,
    );
  }
}
