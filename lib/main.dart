import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async'; // Add async for StreamSubscription
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';
import 'gen_l10n/app_localizations.dart';
import 'screens/auth/language_selection_screen.dart';
import 'screens/auth/auth_flow_coordinator.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/misc/no_internet_screen.dart'; // Import NoInternetScreen
import 'models/user_model.dart';
import 'utils/app_colors.dart';
import 'services/firestore_service.dart';
import 'services/notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize localization for Arabic dates
  await initializeDateFormatting('ar', null);
  await initializeDateFormatting('en', null);

  // Initialize Local Notifications
  await NotificationService().init();

  // Set Background Handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
  bool _isOffline = false; // Add offline state
  late StreamSubscription<List<ConnectivityResult>>
      _connectivitySubscription; // Update subscription type

  @override
  void initState() {
    super.initState();
    _initConnectivity(); // Initialize check
    _loadSavedLanguage();
  }

  Future<void> _initConnectivity() async {
    // Initial check
    final result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);

    // Listen for changes
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    // If ANY of the results is none, check if ALL are none or if we have at least one valid connection
    // ConnectivityResult.none means no connection.
    // However, the list implies multiple interfaces.
    // If the list contains .none and ONLY .none, then offline.
    // Or if the list is empty?

    // Simpler check: if it contains mobile or wifi or ethernet, we are good.
    bool isConnected = result.any((r) =>
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.ethernet ||
        r == ConnectivityResult.vpn);

    setState(() {
      _isOffline = !isConnected;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

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

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguageCode = prefs.getString('selected_language_code');
    if (savedLanguageCode != null) {
      if (mounted) {
        setState(() {
          _currentLocale = Locale(savedLanguageCode);
          // We DO NOT set _isLanguageSelected = true here.
          // This ensures the LanguageSelectionScreen is always shown as the "Landing Page"
          // for unauthenticated users, allowing them to confirm/change language or just proceed.
          // _isLanguageSelected = true;
        });
      }
    }
  }

  void _handleLanguageSelection(Locale locale) async {
    print('Language selected: ${locale.languageCode}');
    setState(() {
      _currentLocale = locale;
      _isLanguageSelected = true;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language_code', locale.languageCode);
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
      builder: (context, child) {
        // Global overlay for No Internet
        if (_isOffline) {
          return NoInternetScreen(
            onRetry: () async {
              final result = await Connectivity().checkConnectivity();
              _updateConnectionStatus(result);
            },
          );
        }
        return child!;
      },
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
        onLanguageChanged: _handleLanguageSelection,
      );
    }

    // ✅ STEP 3: If language selected, show Auth Flow
    if (_isLanguageSelected) {
      print('   → Showing Auth Flow');
      return AuthFlowCoordinator(
        onAuthComplete: _handleAuthComplete,
        onBack: () {
          print('Returning to Language Selection');
          setState(() {
            _isLanguageSelected = false;
            _currentLocale =
                const Locale('en'); // Optional: Reset or keep selection
          });
        },
      );
    }

    // ✅ STEP 4: Otherwise, show Language Selection
    print('   → Showing Language Selection');
    return LanguageSelectionScreen(
      onLanguageSelected: _handleLanguageSelection,
    );
  }
}
