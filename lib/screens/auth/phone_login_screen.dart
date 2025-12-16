import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../gen_l10n/app_localizations.dart';
import '../../utils/app_colors.dart';
import '../../utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/firebase_auth_service.dart';

class PhoneLoginScreen extends StatefulWidget {
  final Function(String phoneNumber, String verificationId) onPhoneSubmit;

  const PhoneLoginScreen({super.key, required this.onPhoneSubmit});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _phoneFocusNode = FocusNode();
  bool _isLoading = false;
  String _selectedCountryCode = '+966';
  String? _phoneError;
  bool _phoneFieldTouched = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhoneRealtime);
    _phoneFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_validatePhoneRealtime);
    _phoneFocusNode.removeListener(_onFocusChange);
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_phoneFocusNode.hasFocus && !_phoneFieldTouched) {
      setState(() => _phoneFieldTouched = true);
    }
  }

  void _validatePhoneRealtime() {
    if (_phoneFieldTouched) {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _phoneError = Validators.validatePhone(
          _phoneController.text,
          _selectedCountryCode,
          l10n,
        );
      });
    }
  }

  Future<void> _handleSubmit() async {
    setState(() => _phoneFieldTouched = true);

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_phoneError ?? 'Please check your phone number'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Normalize digits (convert Arabic indic to Western Arabic)
    String normalizedPhone = _phoneController.text
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

    final fullPhoneNumber = _selectedCountryCode + normalizedPhone;

    try {
      final authService = FirebaseAuthService();

      await authService.verifyPhoneNumber(
        phoneNumber: fullPhoneNumber,
        onVerificationCompleted: (PhoneAuthCredential credential) async {
          await _handleAutoVerification(credential);
        },
        onVerificationFailed: (FirebaseAuthException e) {
          setState(() => _isLoading = false);
          _showErrorDialog(
              e.message ?? 'Verification failed. Please try again.');
        },
        onCodeSent: (String verificationId, int? resendToken) {
          setState(() => _isLoading = false);
          widget.onPhoneSubmit(fullPhoneNumber, verificationId);
        },
        onCodeAutoRetrievalTimeout: (String verificationId) {
          setState(() => _isLoading = false);
          print('Code auto retrieval timeout');
        },
      );
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorDialog('An error occurred. Please try again.');
    }
  }

  Future<void> _handleAutoVerification(PhoneAuthCredential credential) async {
    try {
      final userCredential =
          await FirebaseAuthService().signInWithCredential(credential);
      if (userCredential.user != null) {
        widget.onPhoneSubmit(_phoneController.text, 'auto_verified');
      }
    } catch (e) {
      _showErrorDialog('Auto verification failed. Please enter OTP manually.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade400),
            const SizedBox(width: 8),
            const Text('Error'),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.electricBlue,
            ),
            child: const Text('OK'),
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Header with emoji
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.whatIsYourMobileNumber,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('📱', style: TextStyle(fontSize: 24)),
                  ],
                ),
                const SizedBox(height: 12),

                Text(
                  l10n.enterMobileNumberToSendCode,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 40),

                // Phone Input - Enforce LTR
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Country Code Selector
                      Container(
                        width: 110,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isDark
                                ? Colors.grey.shade700
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () => _showCountryCodePicker(),
                          borderRadius: BorderRadius.circular(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 24,
                                height: 18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    image: NetworkImage(_getCountryFlag()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _selectedCountryCode,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Phone Number Input with Enhanced Validation
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _phoneError != null
                                      ? Colors.red.shade400
                                      : (_phoneFocusNode.hasFocus
                                          ? AppColors.electricBlue
                                          : (isDark
                                              ? Colors.grey.shade700
                                              : Colors.grey.shade300)),
                                  width: _phoneError != null ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: _phoneController,
                                  focusNode: _phoneFocusNode,
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        isDark ? Colors.white : Colors.black87,
                                    letterSpacing: 0.5,
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(
                                        r'[0-9٠-٩]')), // Allow Arabic digits
                                    LengthLimitingTextInputFormatter(
                                        _getMaxLength()),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: _getHintText(),
                                    hintStyle: TextStyle(
                                      color: isDark
                                          ? Colors.grey.shade600
                                          : Colors.grey.shade400,
                                      fontSize: 15,
                                    ),
                                    suffixIcon: _phoneController.text.isNotEmpty
                                        ? IconButton(
                                            icon: Icon(
                                              _phoneError == null
                                                  ? Icons.check_circle
                                                  : Icons.error,
                                              color: _phoneError == null
                                                  ? Colors.green
                                                  : Colors.red,
                                              size: 20,
                                            ),
                                            onPressed: () {},
                                          )
                                        : null,
                                    border: InputBorder.none,
                                    errorStyle:
                                        const TextStyle(height: 0, fontSize: 0),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 0,
                                    ),
                                    isDense: true,
                                  ),
                                  validator: (value) =>
                                      Validators.validatePhone(
                                    value,
                                    _selectedCountryCode,
                                    l10n,
                                  ),
                                ),
                              ),
                            ),
                            // Error message below the field
                            if (_phoneError != null && _phoneFieldTouched)
                              Padding(
                                padding: const EdgeInsets.only(left: 4, top: 6),
                                child: Row(
                                  children: [
                                    Icon(Icons.error_outline,
                                        size: 14, color: Colors.red.shade400),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        _phoneError!,
                                        style: TextStyle(
                                          color: Colors.red.shade400,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            // Helper text when valid
                            if (_phoneError == null &&
                                _phoneController.text.isNotEmpty &&
                                _phoneFieldTouched)
                              Padding(
                                padding: const EdgeInsets.only(left: 4, top: 6),
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle_outline,
                                        size: 14, color: Colors.green.shade600),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Valid phone number',
                                      style: TextStyle(
                                        color: Colors.green.shade600,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Login Button
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
                      onTap: _isLoading ? null : _handleSubmit,
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
                                l10n.login,
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
      ),
    );
  }

  String _getCountryFlag() {
    switch (_selectedCountryCode) {
      case '+966':
        return 'https://flagcdn.com/w40/sa.png';
      case '+971':
        return 'https://flagcdn.com/w40/ae.png';
      case '+92':
        return 'https://flagcdn.com/w40/pk.png';
      default:
        return 'https://flagcdn.com/w40/sa.png';
    }
  }

  int _getMaxLength() {
    switch (_selectedCountryCode) {
      case '+966':
      case '+971':
        return 9;
      case '+92':
        return 10;
      default:
        return 15;
    }
  }

  String _getHintText() {
    switch (_selectedCountryCode) {
      case '+966':
        return '5xxxxxxxx';
      case '+971':
        return '5xxxxxxxx';
      case '+92':
        return '3xxxxxxxxx';
      default:
        return 'Phone number';
    }
  }

  void _showCountryCodePicker() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Select Country Code',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            _buildCountryTile('Saudi Arabia', '+966', 'sa', isDark),
            _buildCountryTile('United Arab Emirates', '+971', 'ae', isDark),
            _buildCountryTile('Pakistan', '+92', 'pk', isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryTile(
      String country, String code, String flagCode, bool isDark) {
    return ListTile(
      leading: Container(
        width: 32,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: NetworkImage('https://flagcdn.com/w40/$flagCode.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        country,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      trailing: Text(code),
      onTap: () {
        setState(() {
          _selectedCountryCode = code;
          _phoneController.clear();
          _phoneError = null;
          _phoneFieldTouched = false;
        });
        Navigator.pop(context);
      },
    );
  }
}
