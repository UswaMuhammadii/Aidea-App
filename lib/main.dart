import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'firebase_options.dart';
import 'gen_l10n/app_localizations.dart';
import 'screens/auth/language_selection_screen.dart';
import 'screens/auth/auth_flow_coordinator.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'models/user_model.dart';
import 'utils/app_colors.dart';
import 'services/firestore_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize localization for Arabic dates
  await initializeDateFormatting('ar', null);
  await initializeDateFormatting('en', null);

  runApp(const CustomerApp());
}

class CustomerApp extends StatefulWidget {
  const CustomerApp({super.key});

  @override
  State<CustomerApp> createState() => _CustomerAppState();
}

class _CustomerAppState extends State<CustomerApp> {
  Locale _currentLocale = const Locale('en'); // Default to English
  bool _isLanguageSelected = false;
  User? _currentUser;
  bool _isLoading = true;

  void _handleSplashComplete() async {
    print('Splash screen complete. Checking for persistent login...');

    try {
      final authUser = firebase_auth.FirebaseAuth.instance.currentUser;
      if (authUser != null) {
        print('Found persisted Firebase user: ${authUser.uid}');
        final firestoreService = FirestoreService();
        final user = await firestoreService.getUser(authUser.uid);

        if (user != null) {
          print('User profile fetched successfully: ${user.name}');
          if (mounted) {
            setState(() {
              _currentUser = user;
            });
          }
        } else {
          print('User profile not found in Firestore.');
        }
      } else {
        print('No persisted user found.');
      }
    } catch (e) {
      print('Error checking persistence: $e');
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleLanguageSelection(Locale locale) {
    print('Language selected: ${locale.languageCode}');
    setState(() {
      _currentLocale = locale;
      _isLanguageSelected = true;
    });
  }

  void _handleAuthComplete(User user) {
    print('AUTH COMPLETE in main.dart');
    print('User: ${user.name}');
    print('Phone: ${user.phone}');
    print('Address: ${user.address}');

    setState(() {
      _currentUser = user;
    });

    print('State updated - Dashboard should appear now!');
  }

  void _handleLogout() async {
    print('LOGOUT - Returning to auth flow');
    try {
      await firebase_auth.FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out of Firebase: $e');
    }

    setState(() {
      _currentUser = null;
      _isLanguageSelected =
          false; // Also reset language selection to go back to language screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HandyMan',
      debugShowCheckedModeBanner: false,
      locale: _currentLocale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
        fontFamily: "Roboto",
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.electricBlue,
        ),
      ),
      home: _buildHome(),
    );
  }

  Widget _buildHome() {
    // ✅ STEP 1: Show Splash Screen while loading
    if (_isLoading) {
      print('Showing Splash Screen');
      return SplashScreen(onSplashComplete: _handleSplashComplete);
    }

    print('Building home - Current state:');
    print('   Language selected: $_isLanguageSelected');
    print('   Current user: ${_currentUser?.name ?? "NULL"}');

    // ✅ STEP 2: If user is logged in, show Dashboard
    if (_currentUser != null) {
      print('   → Showing Dashboard');
      return DashboardScreen(
        user: _currentUser!,
        onLogout: _handleLogout,
      );
    }

    // ✅ STEP 3: If language selected, show Auth Flow
    if (_isLanguageSelected) {
      print('   → Showing Auth Flow');
      return AuthFlowCoordinator(
        onAuthComplete: _handleAuthComplete,
      );
    }

    // ✅ STEP 4: Otherwise, show Language Selection
    print('   → Showing Language Selection');
    return LanguageSelectionScreen(
      onLanguageSelected: _handleLanguageSelection,
    );
  }
}
