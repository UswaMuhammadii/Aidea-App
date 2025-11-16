import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/auth/auth_flow_coordinator.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'models/user_model.dart';
import 'services/dummy_data_service.dart';
import 'services/locale_service.dart';
import 'package:customer_app/app_localizations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleService(),
      child: const CustomerApp(),
    ),
  );
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
  static const success = Color(0xFF10B981);

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
class CustomerApp extends StatelessWidget {
  const CustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleService>(
      builder: (context, localeService, child) {
        return MaterialApp(
          title: 'Aidea Technology',
          debugShowCheckedModeBanner: false,

          // Localization delegates - FIXED: Use the static delegate
          localizationsDelegates: [
            AppLocalizationsDelegate(), // Create instance instead of using static
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
          locale: localeService.locale,

          // RTL support
          builder: (context, child) {
            return Directionality(
              textDirection: localeService.isArabic
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: child!,
            );
          },

          theme: _buildLightTheme(),
          darkTheme: _buildDarkTheme(),
          themeMode: ThemeMode.system,
          home: const AuthWrapper(),
        );
      },
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
        // REMOVED: onBackground is deprecated, use onSurface instead
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
        // REMOVED: onBackground is deprecated, use onSurface instead
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
    );
  }
}

/// 🔐 Auth Wrapper with Phone Authentication Flow
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoggedIn = false;
  User? _currentUser;

  void _handleAuthComplete(User user) {
    DummyDataService.addDummyCompletedBookings(user.id);

    setState(() {
      _isLoggedIn = true;
      _currentUser = user;
    });
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
      _currentUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn && _currentUser != null) {
      return DashboardScreen(
        user: _currentUser!,
        onLogout: _handleLogout,
      );
    } else {
      return AuthFlowCoordinator(
        onAuthComplete: _handleAuthComplete,
      );
    }
  }
}