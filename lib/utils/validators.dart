class Validators {
  // Phone number validation by country code
  static String? validatePhone(String? value, String countryCode, dynamic l10n) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    // Remove spaces, special characters, and country codes
    String cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');

    // Remove country code if present at the start
    if (cleanPhone.startsWith('966')) {
      cleanPhone = cleanPhone.substring(3);
    } else if (cleanPhone.startsWith('971')) {
      cleanPhone = cleanPhone.substring(3);
    } else if (cleanPhone.startsWith('92')) {
      cleanPhone = cleanPhone.substring(2);
    }

    switch (countryCode) {
      case '+966': // Saudi Arabia
        if (cleanPhone.length != 9) {
          return 'Phone must be 9 digits';
        }
        if (!cleanPhone.startsWith('5')) {
          return 'Phone number must start with 5';
        }
        break;
      case '+971': // UAE
        if (cleanPhone.length != 9) {
          return 'Phone must be 9 digits';
        }
        if (!cleanPhone.startsWith('5')) {
          return 'Phone number must start with 5';
        }
        break;
      case '+92': // Pakistan
        if (cleanPhone.length != 10) {
          return 'Phone must be 10 digits';
        }
        if (!cleanPhone.startsWith('3')) {
          return 'Phone number must start with 3';
        }
        break;
      default:
        if (cleanPhone.length < 9 || cleanPhone.length > 15) {
          return 'Invalid phone number length';
        }
    }

    return null;
  }

  // Email validation
  static String? validateEmail(String? value, dynamic l10n) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    // Remove whitespace
    value = value.trim();

    // More strict email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    // Check for @ symbol
    if (!value.contains('@')) {
      return 'Email must contain @';
    }

    // Split by @ to check domain
    final parts = value.split('@');
    if (parts.length != 2) {
      return 'Email must have exactly one @';
    }

    final localPart = parts[0];
    final domain = parts[1];

    // Check local part (before @)
    if (localPart.isEmpty) {
      return 'Email must have username before @';
    }

    // Check domain part (after @)
    if (domain.isEmpty) {
      return 'Email must have domain after @';
    }

    // Check for dot in domain
    if (!domain.contains('.')) {
      return 'Email domain must contain a dot (e.g., gmail.com)';
    }

    // Split domain by dot
    final domainParts = domain.split('.');

    // Check if domain has at least 2 parts (e.g., gmail.com)
    if (domainParts.length < 2) {
      return 'Email domain incomplete (e.g., gmail.com)';
    }

    // Check if last part (TLD) is at least 2 characters
    final tld = domainParts.last;
    if (tld.length < 2) {
      return 'Email domain ending too short (e.g., .com, .org)';
    }

    // Check if second-to-last part exists and is not empty (e.g., "gmail" in gmail.com)
    final domainName = domainParts[domainParts.length - 2];
    if (domainName.isEmpty || domainName.length < 2) {
      return 'Email domain name too short (e.g., gmail.com)';
    }

    // Additional checks
    if (value.contains('..')) {
      return 'Email cannot contain consecutive dots';
    }

    if (value.startsWith('.') || value.endsWith('.')) {
      return 'Email cannot start or end with a dot';
    }

    // Check for spaces
    if (value.contains(' ')) {
      return 'Email cannot contain spaces';
    }

    return null;
  }

  // Name validation
  static String? validateName(String? value, dynamic l10n) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    // Remove extra spaces
    value = value.trim();

    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }

    if (value.length > 50) {
      return 'Name must be less than 50 characters';
    }

    // Check for numbers in name
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Name cannot contain numbers';
    }

    // Check for excessive special characters
    if (RegExp(r'[!@#$%^&*()+=\[\]{};:"\\|<>?/]').hasMatch(value)) {
      return 'Name contains invalid special characters';
    }

    return null;
  }

  // OTP validation
  static String? validateOTP(String? value, dynamic l10n) {
    if (value == null || value.isEmpty) {
      return 'Please enter complete OTP';
    }

    if (value.length != 6) {
      return 'Please enter complete OTP';
    }

    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'OTP must contain only digits';
    }

    return null;
  }

  // Notes/Description validation (optional field)
  static String? validateNotes(String? value, {int maxLength = 500}) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }

    if (value.length > maxLength) {
      return 'Notes cannot exceed $maxLength characters';
    }

    return null;
  }

  // Date validation
  static String? validateDate(DateTime? date, dynamic l10n) {
    if (date == null) {
      return 'Please select a date';
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (date.isBefore(today)) {
      return 'Date cannot be in the past';
    }

    // Optional: limit future dates (e.g., max 1 year ahead)
    final maxFutureDate = today.add(const Duration(days: 365));
    if (date.isAfter(maxFutureDate)) {
      return 'Date cannot be more than 1 year ahead';
    }

    return null;
  }

  // Time validation
  static String? validateTime(DateTime? time, DateTime? selectedDate) {
    if (time == null) {
      return 'Please select a time';
    }

    if (selectedDate != null) {
      final now = DateTime.now();
      final selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        time.hour,
        time.minute,
      );

      // If booking for today, time must be in future
      if (selectedDate.year == now.year &&
          selectedDate.month == now.month &&
          selectedDate.day == now.day) {
        if (selectedDateTime.isBefore(now)) {
          return 'Time must be in the future';
        }

        // Optional: require at least 2 hours notice
        final minBookingTime = now.add(const Duration(hours: 2));
        if (selectedDateTime.isBefore(minBookingTime)) {
          return 'Please book at least 2 hours in advance';
        }
      }
    }

    return null;
  }

  // Quantity validation
  static String? validateQuantity(String? value, dynamic l10n) {
    if (value == null || value.isEmpty) {
      return 'Please enter quantity';
    }

    final quantity = int.tryParse(value);
    if (quantity == null) {
      return 'Please enter a valid number';
    }

    if (quantity < 1) {
      return 'Quantity must be at least 1';
    }

    if (quantity > 100) {
      return 'Quantity cannot exceed 100';
    }

    return null;
  }

  // Generic required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  // Password validation (for future use)
  static String? validatePassword(String? value, dynamic l10n) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (value.length > 50) {
      return 'Password must be less than 50 characters';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one digit
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Address validation (optional but with max length)
  static String? validateAddress(String? value, {int maxLength = 200}) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }

    if (value.trim().isEmpty) {
      return null;
    }

    if (value.length > maxLength) {
      return 'Address cannot exceed $maxLength characters';
    }

    if (value.trim().length < 5) {
      return 'Address is too short';
    }

    return null;
  }
}