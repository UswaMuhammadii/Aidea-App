import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../models/user_model.dart';
import '../../services/firestore_service.dart';
import '../../services/firebase_auth_service.dart';
import 'phone_login_screen.dart';
import 'otp_verification_screen.dart';
import 'location_selection_screen.dart';
import '../../gen_l10n/app_localizations.dart';

class AuthFlowCoordinator extends StatefulWidget {
  final Function(User) onAuthComplete;
  final VoidCallback onBack;

  const AuthFlowCoordinator({
    super.key,
    required this.onAuthComplete,
    required this.onBack,
  });

  @override
  State<AuthFlowCoordinator> createState() => _AuthFlowCoordinatorState();
}

class _AuthFlowCoordinatorState extends State<AuthFlowCoordinator> {
  int _currentStep = 0;
  String _phoneNumber = '';
  String _verificationId = '';
  Map<String, String> _locationData = {};
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();
  firebase_auth.User? _firebaseUser;

  @override
  void initState() {
    super.initState();
    // Check if user is already logged in
    _firebaseUser = _authService.getCurrentUser();
    if (_firebaseUser != null) {
      debugPrint('User already logged in: ${_firebaseUser!.phoneNumber}');
    }
  }

  void _handlePhoneSubmit(String phoneNumber, String verificationId) {
    debugPrint('=== Phone Submit Handler ===');
    debugPrint('Phone: $phoneNumber');
    debugPrint('VerificationId: $verificationId');
    debugPrint('VerificationId length: ${verificationId.length}');

    setState(() {
      _phoneNumber = phoneNumber;
      _verificationId = verificationId;
      _authService.setVerificationId(verificationId);
      _currentStep = 1; // Move to OTP verification
    });

    debugPrint('State updated - Moving to OTP screen');
    debugPrint('============================');
  }

  Future<void> _handleOTPVerification(firebase_auth.User firebaseUser) async {
    debugPrint('=== OTP Verification Handler ===');
    debugPrint('Firebase User: ${firebaseUser.uid}');

    // Check if user exists in Firestore
    final existingUser = await _firestoreService.getUser(firebaseUser.uid);
    if (existingUser != null) {
      debugPrint('User found in Firestore: ${existingUser.name}');
      widget.onAuthComplete(existingUser);
      return;
    }

    setState(() {
      _firebaseUser = firebaseUser;
      _phoneNumber = firebaseUser.phoneNumber ?? _phoneNumber;
      _currentStep = 2; // Move to location selection
    });

    debugPrint('State updated - Moving to Location screen');
    debugPrint('=================================');
  }

  void _handleLocationSelected(Map<String, String> locationData) {
    setState(() {
      _locationData = locationData;
    });
    _completeAuth();
  }

  Future<void> _completeAuth() async {
    final l10n = AppLocalizations.of(context)!;
    // Create user with collected data and Firebase UID
    final user = User(
      id: _firebaseUser?.uid ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      email: _locationData['email'] ?? '$_phoneNumber@example.com',
      name: _locationData['name'] ?? _phoneNumber.replaceAll('+', ''),
      phone: _phoneNumber,
      address: _buildCompleteAddress(),
      createdAt: DateTime.now(),
      languagePreference: l10n.localeName,
    );

    await _firestoreService.saveUser(user);

    widget.onAuthComplete(user);
  }

  String _buildCompleteAddress() {
    final street = _locationData['street'] ?? '';
    final floor = _locationData['floor'] ?? '';
    final apartment = _locationData['apartment'] ?? '';
    final otherInfo = _locationData['otherInfo'] ?? '';

    final addressParts = [
      if (street.isNotEmpty) street,
      if (floor.isNotEmpty) 'Floor $floor',
      if (apartment.isNotEmpty) 'Apt $apartment',
      if (otherInfo.isNotEmpty) otherInfo,
    ];

    return addressParts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: IndexedStack(
        index: _currentStep,
        children: [
          // Step 0: Phone Login
          PhoneLoginScreen(
            onPhoneSubmit: _handlePhoneSubmit,
            onBack: widget.onBack,
          ),

          // Step 1: OTP Verification
          // ✅ FIX: Add key with verificationId to force rebuild when it changes
          if (_verificationId.isNotEmpty)
            OTPVerificationScreen(
              key: ValueKey(
                  _verificationId), // This forces rebuild with new verificationId
              phoneNumber: _phoneNumber,
              verificationId: _verificationId,
              onVerificationSuccess: _handleOTPVerification,
            )
          else
            // Placeholder while waiting for verificationId
            const Center(child: CircularProgressIndicator()),

          // Step 2: Location Selection
          LocationSelectionScreen(
            onLocationSelected: _handleLocationSelected,
            onBack: () {
              setState(() {
                _currentStep = 1; // Go back to OTP verification
              });
            },
          ),
        ],
      ),
    );
  }
}
