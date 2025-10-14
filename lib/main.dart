import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/services/service_checkout_screen.dart';
import 'screens/services/service_listing_screen.dart';
import 'screens/booking/booking_confirmation_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'models/user_model.dart';
import 'models/service_model.dart';
import 'models/booking_model.dart';
import 'services/dummy_data_service.dart';

// Entry point
void main() {
  runApp(const CustomerApp());
}

/// 🌈 Brand Colors & Gradients inspired by your logo
class AppColors {
  // Core gradient colors (Purple → Blue → Teal)
  static const deepPurple = Color(0xFF7C3AED);
  static const electricBlue = Color(0xFF3B82F6);
  static const brightTeal = Color(0xFF14B8A6);

  // Supporting colors
  static const darkPurple = Color(0xFF6D28D9);
  static const lightPurple = Color(0xFF8B5CF6);
  static const darkBlue = Color(0xFF2563EB);
  static const lightBlue = Color(0xFF60A5FA);
  static const darkTeal = Color(0xFF0D9488);
  static const lightTeal = Color(0xFF2DD4BF);

  // Neutral
  static const background = Color(0xFFF8FAFC);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF1F5F9);
  static const onSurface = Color(0xFF0F172A);
  static const onSurfaceVariant = Color(0xFF64748B);

  // Dark Mode
  static const darkBackground = Color(0xFF0F172A);
  static const darkSurface = Color(0xFF1E293B);
  static const darkSurfaceVariant = Color(0xFF334155);
  static const darkOnSurface = Color(0xFFF8FAFC);
  static const darkOnSurfaceVariant = Color(0xFFCBD5E1);

  // Gradients
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

/// 🌟 Main App Widget
class CustomerApp extends StatelessWidget {
  const CustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aidea Technology',
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => LoginScreen(onLogin: (user) {}),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final user = args?['user'] as User? ??
              User(id: '', email: '', name: '', phone: '', createdAt: DateTime.now());
          return DashboardScreen(user: user, onLogout: () {});
        },
        '/checkout': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final service = args?['service'] as Service?;
          final user = args?['user'] as User?;
          if (service == null || user == null) {
            return const Scaffold(body: Center(child: Text('Error: Missing arguments')));
          }
          return ServiceCheckoutScreen(service: service, user: user);
        },
        '/services': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final categoryName = args?['categoryName'] as String? ?? 'AC Services';
          final user = args?['user'] as User? ??
              User(id: '', email: '', name: '', phone: '', createdAt: DateTime.now());
          return ServiceListingScreen(categoryName: categoryName, user: user);
        },
        '/cart': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final user = args?['user'] as User? ??
              User(id: '', email: '', name: '', phone: '', createdAt: DateTime.now());
          return CartScreen(user: user);
        },
        '/confirmation': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final bookings = args?['bookings'] as List<Booking>?;
          final user = args?['user'] as User?;
          final totalAmount = args?['totalAmount'] as double?;
          if (bookings == null || user == null || totalAmount == null) {
            return const Scaffold(body: Center(child: Text('Error: Missing arguments')));
          }
          return BookingConfirmationScreen(
            bookings: bookings,
            user: user,
            totalAmount: totalAmount,
          );
        },
        '/profile': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final user = args?['user'] as User? ??
              User(id: '', email: '', name: '', phone: '', createdAt: DateTime.now());
          return ProfileScreen(user: user, onLogout: () {});
        },
      },
    );
  }

  /// 🌞 LIGHT THEME
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

      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.onSurface),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant),
      ),

      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.onSurface,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.surfaceVariant),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: AppColors.deepPurple, width: 1.8),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deepPurple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.electricBlue,
        foregroundColor: Colors.white,
      ),
    );
  }

  /// 🌚 DARK THEME
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

      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.white60),
      ),

      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkOnSurface,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.darkOnSurface,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.darkSurfaceVariant),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: AppColors.lightPurple, width: 1.8),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightPurple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.lightBlue,
        foregroundColor: Colors.white,
      ),
    );
  }
}

/// 🔐 Auth Wrapper
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoggedIn = false;
  User? _currentUser;

  void _login(User user) {
    setState(() {
      _isLoggedIn = true;
      _currentUser = user;
    });
  }

  void _logout() {
    setState(() {
      _isLoggedIn = false;
      _currentUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn && _currentUser != null) {
      return DashboardScreen(user: _currentUser!, onLogout: _logout);
    } else {
      return LoginScreen(onLogin: _login);
    }
  }
}
