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
import 'models/cart_model.dart';
import 'services/dummy_data_service.dart';

void main() {
  runApp(const CustomerApp());
}

class CustomerApp extends StatelessWidget {
  const CustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aidea Technology',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C3AED), // Purple
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),
      ),
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => LoginScreen(onLogin: (user) {}),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final user = args?['user'] as User? ?? User(id: '', email: '', name: '', phone: '', createdAt: DateTime.now());
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
          final user = args?['user'] as User? ?? User(id: '', email: '', name: '', phone: '', createdAt: DateTime.now());
          return ServiceListingScreen(categoryName: categoryName, user: user);
        },
        '/cart': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final user = args?['user'] as User? ?? User(id: '', email: '', name: '', phone: '', createdAt: DateTime.now());
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
          final user = args?['user'] as User? ?? User(id: '', email: '', name: '', phone: '', createdAt: DateTime.now());
          return ProfileScreen(user: user, onLogout: () {});
        },
      },
    );
  }
}

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
      return DashboardScreen(
        user: _currentUser!,
        onLogout: _logout,
      );
    } else {
      return LoginScreen(onLogin: _login);
    }
  }
}