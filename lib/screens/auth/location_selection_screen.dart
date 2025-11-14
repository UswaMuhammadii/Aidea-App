// Update location_selection_screen.dart - Add better validation

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _streetController = TextEditingController();
  final _floorController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _otherInfoController = TextEditingController();

  bool _saveAsPrimary = true;
  String _addressType = 'Home';
  String _selectedLocation = '19231, Saudi Arabia';

  // Add email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    // Email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    
    return null;
  }

  // Add name validation
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    
    if (value.trim().length > 50) {
      return 'Name must be less than 50 characters';
    }
    
    // Check if name contains only letters and spaces
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    
    return null;
  }

  // Add street validation
  String? _validateStreet(String? value) {
    if (value == null || value.isEmpty) {
      return 'Street name is required';
    }
    
    if (value.trim().length < 3) {
      return 'Street name must be at least 3 characters';
    }
    
    return null;
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors in the form'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final addressData = {
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim().toLowerCase(),
      'street': _streetController.text.trim(),
      'floor': _floorController.text.trim(),
      'apartment': _apartmentController.text.trim(),
      'otherInfo': _otherInfoController.text.trim(),
      'type': _addressType,
      'location': _selectedLocation,
    };

    widget.onLocationSelected(addressData);
  }

  @override
  Widget build(BuildContext context) {
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
              // Map Preview (keep existing)
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
                    Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Full Name with validation
                    Text(
                      'Full Name *',
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
                      textCapitalization: TextCapitalization.words,
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
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ),
                      validator: _validateName,
                    ),
                    const SizedBox(height: 16),

                    // Email with validation
                    Text(
                      'Email Address *',
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
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ),
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 24),

                    Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Street Name with validation
                    Text(
                      'Street Name *',
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
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: 'Enter street name',
                        hintStyle: TextStyle(
                          color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                        ),
                        filled: true,
                        fillColor: isDark ? const Color(0xFF1E293B) : Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ),
                      validator: _validateStreet,
                    ),
                    const SizedBox(height: 20),

                    // Floor and Apartment (Optional)
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Floor (Optional)',
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
                                keyboardType: TextInputType.text,
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
                                'Apartment (Optional)',
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
                                keyboardType: TextInputType.text,
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

                    // Other Information (keep existing)
                    Text(
                      'Other information (Optional)',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _otherInfoController,
                      maxLines: 3,
                      maxLength: 200,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Landmarks, special instructions, etc.',
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
                    ),
                    const SizedBox(height: 24),

                    // Save as Primary (keep existing)
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

                    // Address Type Selection (keep existing)
                    Row(
                      children: [
                        _buildAddressTypeChip('Home', Icons.home),
                        const SizedBox(width: 12),
                        _buildAddressTypeChip('Work', Icons.work),
                        const SizedBox(width: 12),
                        _buildAddressTypeChip('Friend', Icons.person),
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
                            color: AppColors.deepPurple.withOpacity(0.3),
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

  // Keep existing _buildAddressTypeChip method
  Widget _buildAddressTypeChip(String label, IconData icon) {
    // ... existing code
  }
}
