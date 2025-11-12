import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/dummy_data_service.dart';
import 'phone_login_screen.dart';
import 'otp_verification_screen.dart';
import 'location_selection_screen.dart';
import '../../gen_l10n/app_localizations.dart';

class AuthFlowCoordinator extends StatefulWidget {
  final Function(User) onAuthComplete;

  const AuthFlowCoordinator({
    super.key,
    required this.onAuthComplete,
  });

  @override
  State<AuthFlowCoordinator> createState() => _AuthFlowCoordinatorState();
}

class _AuthFlowCoordinatorState extends State<AuthFlowCoordinator> {
  int _currentStep = 0;
  String _phoneNumber = '';
  Map<String, String> _locationData = {};

  void _handlePhoneSubmit(String phoneNumber) {
    setState(() {
      _phoneNumber = phoneNumber;
      _currentStep = 1; // Move to OTP verification
    });
  }

  void _handleOTPVerification() {
    setState(() {
      _currentStep = 2; // Move to location selection
    });
  }

  void _handleLocationSelected(Map<String, String> locationData) {
    setState(() {
      _locationData = locationData;
    });
    _completeAuth();
  }

  void _completeAuth() {
    // Create user with collected data
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: _locationData['email'] ?? '$_phoneNumber@example.com',
      name: _locationData['name'] ?? _phoneNumber.replaceAll('+', ''),
      phone: _phoneNumber,
      address: _buildCompleteAddress(),
      createdAt: DateTime.now(),
    );

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
          ),

          // Step 1: OTP Verification
          OTPVerificationScreen(
            phoneNumber: _phoneNumber,
            onVerificationSuccess: _handleOTPVerification,
          ),

          // Step 2: Location Selection
          LocationSelectionScreen(
            onLocationSelected: _handleLocationSelected,
          ),
        ],
      ),
    );
  }
}