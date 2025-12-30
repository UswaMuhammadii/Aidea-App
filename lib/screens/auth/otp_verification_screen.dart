import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../../gen_l10n/app_localizations.dart';
import '../../utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/firebase_auth_service.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final Function(User) onVerificationSuccess; // Updated to pass Firebase User

  const OTPVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    required this.onVerificationSuccess,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  bool _isLoading = false;
  bool _canResend = false;
  int _remainingSeconds = 120;
  Timer? _timer;
  String _currentVerificationId = '';

  @override
  void initState() {
    super.initState();
    _currentVerificationId = widget.verificationId;
    _startTimer();

    // DEBUG: Print verification details
    debugPrint('=== OTP Screen Initialized ===');
    debugPrint('Phone: ${widget.phoneNumber}');
    debugPrint('VerificationId: ${widget.verificationId}');
    debugPrint('VerificationId length: ${widget.verificationId.length}');
    debugPrint('==============================');
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _remainingSeconds = 120;
    _canResend = false;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        setState(() => _canResend = true);
        timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Future<void> _verifyOTP() async {
    final l10n = AppLocalizations.of(context)!;
    // Normalize digits (convert Arabic indic to Western Arabic)
    String otp = _controllers
        .map((c) => c.text)
        .join()
        .replaceAll('٠', '0')
        .replaceAll('١', '1')
        .replaceAll('٢', '2')
        .replaceAll('٣', '3')
        .replaceAll('٤', '4')
        .replaceAll('٥', '5')
        .replaceAll('٦', '6')
        .replaceAll('٧', '7')
        .replaceAll('٨', '8')
        .replaceAll('٩', '9');

    // DEBUG: Print OTP details
    debugPrint('=== Starting OTP Verification ===');
    debugPrint('OTP entered: $otp');
    debugPrint('Using VerificationId: $_currentVerificationId');
    debugPrint('===================================');

    if (otp.length != 6) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.pleaseEnterCompleteOtp),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Check if verificationId is valid
    if (_currentVerificationId.isEmpty) {
      _showErrorDialog(l10n.sessionExpired);
      debugPrint('ERROR: VerificationId is empty!');
      return;
    }

    setState(() => _isLoading = true);

    try {
      debugPrint('Creating PhoneAuthCredential...');
      final credential = PhoneAuthProvider.credential(
        verificationId: _currentVerificationId,
        smsCode: otp,
      );

      debugPrint('Signing in with credential...');
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      debugPrint('SUCCESS! User ID: ${userCredential.user?.uid}');
      debugPrint('Phone: ${userCredential.user?.phoneNumber}');

      if (mounted && userCredential.user != null) {
        setState(() => _isLoading = false);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.phoneVerified),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 1),
          ),
        );

        // Small delay then proceed with Firebase User object
        await Future.delayed(const Duration(milliseconds: 500));
        widget.onVerificationSuccess(userCredential.user!);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.code} - ${e.message}');

      if (mounted) {
        setState(() => _isLoading = false);

        String errorMessage;
        switch (e.code) {
          case 'invalid-verification-code':
            errorMessage = l10n.invalidOtp;
            // Removed hardcoded test number hint for production professionalism users might still want it but it's hardcoded english. I will leave it out or map it if requested. For now I use localized string.
            // If debug mode:
            if (widget.phoneNumber.contains('4242479')) {
              errorMessage += '\n\n${l10n.testNumberHint}';
            }
            break;
          case 'session-expired':
            errorMessage = l10n.otpExpired;
            break;
          case 'invalid-verification-id':
            errorMessage = l10n.sessionInvalid;
            break;
          case 'credential-already-in-use':
            errorMessage = l10n.phoneAlreadyRegistered;
            // This is actually success - phone already verified
            // Get current user and proceed
            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null) {
              await Future.delayed(const Duration(milliseconds: 500));
              widget.onVerificationSuccess(currentUser);
            }
            return;
          default:
            errorMessage =
                'Verification failed: ${e.message}\n\nError code: ${e.code}';
        }

        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      debugPrint('Unexpected error: $e');

      if (mounted) {
        setState(() => _isLoading = false);
        _showErrorDialog('Unexpected error occurred:\n${e.toString()}');
      }
    }
  }

  Future<void> _resendOTP() async {
    if (!_canResend) return;

    final l10n = AppLocalizations.of(context)!;
    debugPrint('=== Resending OTP ===');
    setState(() => _isLoading = true);

    try {
      await FirebaseAuthService().verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        onVerificationCompleted: (PhoneAuthCredential credential) async {
          debugPrint('Auto verification completed');
          await _handleAutoVerification(credential);
        },
        onVerificationFailed: (FirebaseAuthException e) {
          debugPrint('Verification failed: ${e.code} - ${e.message}');
          setState(() => _isLoading = false);
          _showErrorDialog(e.message ?? l10n.verificationFailed);
        },
        onCodeSent: (String verificationId, int? resendToken) {
          debugPrint('New code sent. VerificationId: $verificationId');
          setState(() {
            _isLoading = false;
            _currentVerificationId = verificationId;
          });

          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.otpSentSuccessfully),
              backgroundColor: Colors.green,
            ),
          );

          _startTimer();
        },
        onCodeAutoRetrievalTimeout: (String verificationId) {
          debugPrint('Auto retrieval timeout: $verificationId');
          setState(() => _isLoading = false);
        },
      );
    } catch (e) {
      debugPrint('Resend error: $e');
      setState(() => _isLoading = false);
      _showErrorDialog(l10n.failedToResendOtp);
    }
  }

  Future<void> _handleAutoVerification(PhoneAuthCredential credential) async {
    try {
      setState(() => _isLoading = true);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (mounted && userCredential.user != null) {
        setState(() => _isLoading = false);
        widget.onVerificationSuccess(userCredential.user!);
      }
    } catch (e) {
      debugPrint('Auto verification error: $e');
      setState(() => _isLoading = false);
    }
  }

  void _showErrorDialog(String message) {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.errorTitle),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.okAction),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = false;
    final backgroundColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header
              Text(
                l10n.enterCodeSentToYou,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                '${l10n.confirmationCodeSentTo}\n${widget.phoneNumber}',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  height: 1.5,
                ),
              ),

              // Debug info (remove in production)
              if (widget.phoneNumber.contains('4242479')) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Text(
                    l10n.testNumberHint,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 40),

              // OTP Input Boxes - 6 boxes
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return Container(
                      width: 50,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _controllers[index].text.isNotEmpty
                              ? AppColors.electricBlue
                              : (isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9٠-٩]')), // Allow Arabic digits
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            _focusNodes[index + 1].requestFocus();
                          } else if (value.isEmpty && index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }

                          // Auto-verify when all 6 digits entered
                          if (index == 5 && value.isNotEmpty) {
                            FocusScope.of(context).unfocus(); // Hide keyboard
                            _verifyOTP();
                          }
                        },
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),

              // Resend Code
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.didntReceiveCode,
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                  TextButton(
                    onPressed: _canResend ? _resendOTP : null,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      l10n.resend,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _canResend
                            ? AppColors.electricBlue
                            : (isDark
                                ? Colors.grey.shade600
                                : Colors.grey.shade400),
                      ),
                    ),
                  ),
                  if (!_canResend)
                    Text(
                      '  ${_formatTime(_remainingSeconds)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 40),

              // Manual Verify Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.electricBlue,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.electricBlue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _isLoading ? null : _verifyOTP,
                    borderRadius: BorderRadius.circular(16),
                    child: Center(
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              l10n.verify,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
