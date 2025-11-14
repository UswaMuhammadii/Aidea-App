class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );
    
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    
    return null;
  }

  // Name validation
  static String? validateName(String? value, {int minLength = 2, int maxLength = 50}) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    
    if (value.trim().length < minLength) {
      return 'Name must be at least $minLength characters';
    }
    
    if (value.trim().length > maxLength) {
      return 'Name must be less than $maxLength characters';
    }
    
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    
    return null;
  }

  // Phone validation with country code support
  static String? validatePhone(String? value, String countryCode) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    String cleaned = value.replaceAll(RegExp(r'[^\d]'), '');
    
    switch (countryCode) {
      case '+966': // Saudi Arabia
        if (cleaned.length != 9) {
          return 'Saudi number must be 9 digits';
        }
        if (!cleaned.startsWith('5')) {
          return 'Saudi number must start with 5';
        }
        break;
      case '+971': // UAE
        if (cleaned.length != 9) {
          return 'UAE number must be 9 digits';
        }
        if (!cleaned.startsWith('5')) {
          return 'UAE number must start with 5';
        }
        break;
      case '+92': // Pakistan
        if (cleaned.length != 10) {
          return 'Pakistan number must be 10 digits';
        }
        if (!cleaned.startsWith('3')) {
          return 'Pakistan number must start with 3';
        }
        break;
      default:
        if (cleaned.length < 9 || cleaned.length > 15) {
          return 'Invalid phone number length';
        }
    }
    
    return null;
  }

  // Generic text validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Min length validation
  static String? validateMinLength(String? value, int minLength, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    if (value.trim().length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }
    return null;
  }

  // Max length validation
  static String? validateMaxLength(String? value, int maxLength, String fieldName) {
    if (value != null && value.trim().length > maxLength) {
      return '$fieldName must be less than $maxLength characters';
    }
    return null;
  }

  // Date validation (not in past)
  static String? validateFutureDate(DateTime? date) {
    if (date == null) {
      return 'Date is required';
    }
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDate = DateTime(date.year, date.month, date.day);
    
    if (selectedDate.isBefore(today)) {
      return 'Cannot select a past date';
    }
    
    return null;
  }

  // Time validation
  static String? validateFutureTime(DateTime? date, TimeOfDay? time) {
    if (date == null || time == null) {
      return 'Date and time are required';
    }
    
    final selectedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    
    if (selectedDateTime.isBefore(DateTime.now())) {
      return 'Cannot select a past time';
    }
    
    return null;
  }

  // Password validation (if you add password feature later)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    
    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }
}
