import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../gen_l10n/app_localizations.dart';


class AppColors {
  static const deepPurple = Color(0xFF7C3AED);
  static const electricBlue = Color(0xFF3B82F6);
  static const brightTeal = Color(0xFF14B8A6);

  static const primaryGradient = LinearGradient(
    colors: [deepPurple, electricBlue, brightTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class PhoneLoginScreen extends StatefulWidget {
  final Function(String phoneNumber) onPhoneSubmit;

  const PhoneLoginScreen({super.key, required this.onPhoneSubmit});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _selectedCountryCode = '+966';
  bool _showError = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    final fullPhoneNumber = _selectedCountryCode + _phoneController.text;
    widget.onPhoneSubmit(fullPhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : Colors.white;

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

                // Phone Input
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Country Code Selector
                    Container(
                      width: 110,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
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
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://flagcdn.com/w40/sa.png',
                                  ),
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

                    // Phone Number Input with Error Message
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _showError
                                    ? Colors.red.shade400
                                    : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                                width: _showError ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: isDark ? Colors.white : Colors.black87,
                                  letterSpacing: 0.5,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                decoration: InputDecoration(
                                  hintText: '5xxxxxxxxx',
                                  hintStyle: TextStyle(
                                    color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                                    fontSize: 15,
                                  ),
                                  border: InputBorder.none,
                                  errorStyle: const TextStyle(height: 0, fontSize: 0),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 0,
                                  ),
                                  isDense: true,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _showError = value.isNotEmpty && value.length < 9;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'error';
                                  }
                                  if (value.length < 9) {
                                    return 'error';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          // Error message below the field
                          if (_showError)
                            Padding(
                              padding: const EdgeInsets.only(left: 4, top: 6),
                              child: Text(
                                l10n.invalidNumber,
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
                  ],
                ),
                const SizedBox(height: 40),

                // Login Button
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.deepPurple.withValues(alpha: 0.3),
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
            ListTile(
              leading: Container(
                width: 32,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: const DecorationImage(
                    image: NetworkImage('https://flagcdn.com/w40/sa.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                'Saudi Arabia',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              trailing: const Text('+966'),
              onTap: () {
                setState(() => _selectedCountryCode = '+966');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Container(
                width: 32,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: const DecorationImage(
                    image: NetworkImage('https://flagcdn.com/w40/ae.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                'United Arab Emirates',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              trailing: const Text('+971'),
              onTap: () {
                setState(() => _selectedCountryCode = '+971');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Container(
                width: 32,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: const DecorationImage(
                    image: NetworkImage('https://flagcdn.com/w40/pk.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                'Pakistan',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              trailing: const Text('+92'),
              onTap: () {
                setState(() => _selectedCountryCode = '+92');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}