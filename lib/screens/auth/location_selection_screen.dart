import 'package:flutter/material.dart';
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

class LocationSelectionScreen extends StatefulWidget {
  final Function(Map<String, String>) onLocationSelected;

  const LocationSelectionScreen({
    super.key,
    required this.onLocationSelected,
  });

  @override
  State<LocationSelectionScreen> createState() => _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _streetController = TextEditingController();
  final _floorController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _otherInfoController = TextEditingController();

  bool _saveAsPrimary = true;
  late String _addressType;
  String _selectedLocation = '19231, Saudi Arabia';

  @override
  void initState() {
    super.initState();
    // Initialize _addressType in initState where we can't access context yet
    // It will be properly set in build method
    _addressType = 'Home'; // Default value, will be localized in build
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _streetController.dispose();
    _floorController.dispose();
    _apartmentController.dispose();
    _otherInfoController.dispose();
    super.dispose();
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) return;

    final addressData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'street': _streetController.text,
      'floor': _floorController.text,
      'apartment': _apartmentController.text,
      'otherInfo': _otherInfoController.text,
      'type': _addressType,
      'location': _selectedLocation,
    };

    widget.onLocationSelected(addressData);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Initialize _addressType with localized value if it's still the default
    if (_addressType == 'Home') {
      _addressType = l10n.home;
    }

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
        title: Text(
          'Complete Your Profile',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Map Preview
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.grey.shade200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      'https://maps.googleapis.com/maps/api/staticmap?center=19231,Saudi+Arabia&zoom=13&size=600x300&maptype=roadmap&markers=color:green%7C19231,Saudi+Arabia&key=YOUR_API_KEY',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.map,
                                size: 64,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Map Preview',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const Icon(
                      Icons.location_on,
                      color: Colors.green,
                      size: 48,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Personal Information Section
                    Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Full Name
                    Text(
                      l10n.fullName,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        hintStyle: TextStyle(
                          color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                        ),
                        filled: true,
                        fillColor: isDark ? const Color(0xFF1E293B) : Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.pleaseEnterYourName;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Email
                    Text(
                      l10n.emailAddress,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                        ),
                        filled: true,
                        fillColor: isDark ? const Color(0xFF1E293B) : Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.pleaseEnterYourEmail;
                        }
                        if (!value.contains('@')) {
                          return l10n.pleaseEnterValidEmail;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Address Details Section
                    Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Street Name
                    Text(
                      'Street Name',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _streetController,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDark ? const Color(0xFF1E293B) : Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter street name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Floor and Apartment
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Floor',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _floorController,
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Floor number',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                  ),
                                  filled: true,
                                  fillColor: isDark
                                      ? const Color(0xFF1E293B)
                                      : Colors.grey.shade100,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Apartment',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _apartmentController,
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Apartment number',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                  ),
                                  filled: true,
                                  fillColor: isDark
                                      ? const Color(0xFF1E293B)
                                      : Colors.grey.shade100,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Other Information
                    Text(
                      'Other information',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _otherInfoController,
                      maxLines: 3,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDark ? const Color(0xFF1E293B) : Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Save as Primary
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Save address as primary',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        Switch(
                          value: _saveAsPrimary,
                          onChanged: (value) {
                            setState(() => _saveAsPrimary = value);
                          },
                          activeColor: AppColors.electricBlue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Address Type Selection
                    Row(
                      children: [
                        _buildAddressTypeChip(l10n.home, Icons.home, l10n),
                        const SizedBox(width: 12),
                        _buildAddressTypeChip('Work', Icons.work, l10n),
                        const SizedBox(width: 12),
                        _buildAddressTypeChip('Friend', Icons.person, l10n),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Save Button
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
                          onTap: _saveAddress,
                          borderRadius: BorderRadius.circular(16),
                          child: const Center(
                            child: Text(
                              'Save & Continue',
                              style: TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressTypeChip(String label, IconData icon, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _addressType == label;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() => _addressType = label);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? AppColors.deepPurple.withValues(alpha: 0.2) : Colors.grey.shade200)
                : (isDark ? const Color(0xFF1E293B) : Colors.grey.shade100),
            border: Border.all(
              color: isSelected
                  ? AppColors.deepPurple
                  : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? AppColors.deepPurple
                    : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? AppColors.deepPurple
                      : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}