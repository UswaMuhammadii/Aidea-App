import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../models/user_model.dart';
import '../../gen_l10n/app_localizations.dart';
import '../../utils/app_colors.dart';
import '../../utils/validators.dart';
import '../../services/firestore_service.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  bool _isLoading = false;
  bool _hasChanges = false;

  // Real-time validation states
  String? _nameError;
  String? _emailError;
  String? _phoneError;

  bool _nameFieldTouched = false;
  bool _emailFieldTouched = false;
  bool _phoneFieldTouched = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);

    // Add listeners for real-time validation
    _nameController.addListener(_onNameChanged);
    _emailController.addListener(_onEmailChanged);
    _phoneController.addListener(_onPhoneChanged);

    _nameFocusNode.addListener(() => _markFieldTouched('name'));
    _emailFocusNode.addListener(() => _markFieldTouched('email'));
    _phoneFocusNode.addListener(() => _markFieldTouched('phone'));
  }

  @override
  void dispose() {
    _nameController.removeListener(_onNameChanged);
    _emailController.removeListener(_onEmailChanged);
    _phoneController.removeListener(_onPhoneChanged);

    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();

    super.dispose();
  }

  void _markFieldTouched(String field) {
    if (mounted) {
      setState(() {
        switch (field) {
          case 'name':
            if (!_nameFocusNode.hasFocus) _nameFieldTouched = true;
            break;
          case 'email':
            if (!_emailFocusNode.hasFocus) _emailFieldTouched = true;
            break;
          case 'phone':
            if (!_phoneFocusNode.hasFocus) _phoneFieldTouched = true;
            break;
        }
      });
    }
  }

  void _onNameChanged() {
    _checkForChanges();
    if (_nameFieldTouched) {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _nameError = Validators.validateName(_nameController.text, l10n);
      });
    }
  }

  void _onEmailChanged() {
    _checkForChanges();
    if (_emailFieldTouched) {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _emailError = Validators.validateEmail(_emailController.text, l10n);
      });
    }
  }

  void _onPhoneChanged() {
    _checkForChanges();
    if (_phoneFieldTouched) {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _phoneError =
            Validators.validatePhone(_phoneController.text, '+966', l10n);
      });
      debugPrint(
          'Phone validation: ${_phoneController.text} -> Error: $_phoneError');
    }
  }

  void _checkForChanges() {
    final hasChanges = _nameController.text != widget.user.name ||
        _emailController.text != widget.user.email ||
        _selectedImage != null ||
        _phoneController.text != widget.user.phone;

    if (hasChanges != _hasChanges) {
      setState(() => _hasChanges = hasChanges);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _checkForChanges();
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showImageSourceModal() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(l10n.camera),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(l10n.gallery),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProfile(AppLocalizations l10n) async {
    // Mark all fields as touched for visual feedback
    setState(() {
      _nameFieldTouched = true;
      _emailFieldTouched = true;
      _phoneFieldTouched = true;
    });

    // Validate the form
    final isValid = _formKey.currentState!.validate();

    // Also check our real-time validation states
    final hasErrors =
        _nameError != null || _emailError != null || _phoneError != null;

    debugPrint('Form valid: $isValid');
    debugPrint('Name error: $_nameError');
    debugPrint('Email error: $_emailError');
    debugPrint('Phone error: $_phoneError');

    if (!isValid || hasErrors) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.fixErrors(
              _nameError ?? _emailError ?? _phoneError ?? l10n.genericError)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    if (!_hasChanges) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.noChangesToSave),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Create updated user object
    final updatedUser = User(
      id: widget.user.id,
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      address: widget.user.address,
      createdAt: widget.user.createdAt,
      profileImage: _selectedImage?.path ?? widget.user.profileImage,
    );

    try {
      await FirestoreService().saveUser(updatedUser);
    } catch (e) {
      debugPrint('Error saving profile: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      setState(() => _isLoading = false);
      return;
    }

    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              Text(l10n.profileUpdatedSuccessfully),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      // Return the updated user
      Navigator.pop(context, updatedUser);
    }
  }

  Future<bool> _onWillPop() async {
    if (!_hasChanges) return true;
    final l10n = AppLocalizations.of(context)!;

    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(l10n.discardChangesTitle),
            content: Text(l10n.discardChangesContent),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: Text(l10n.discard),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return PopScope(
      canPop: !_hasChanges,
      onPopInvoked: (didPop) async {
        if (!didPop && _hasChanges) {
          final shouldPop = await _onWillPop();
          if (shouldPop && mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text(l10n.editProfile),
          centerTitle: true,
          backgroundColor: cardColor,
          foregroundColor: textColor,
          elevation: 0,
          iconTheme: IconThemeData(color: textColor),
          actions: [
            if (_hasChanges)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 14, color: Colors.orange),
                      SizedBox(width: 4),
                      Text(
                        l10n.unsaved,
                        style: TextStyle(fontSize: 12, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                // Profile Picture
                Center(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.electricBlue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.electricBlue.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: cardColor,
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : (widget.user.profileImage != null
                                  ? FileImage(File(widget.user.profileImage!))
                                  : null) as ImageProvider?,
                          child: (_selectedImage == null &&
                                  widget.user.profileImage == null)
                              ? Text(
                                  _nameController.text.isNotEmpty
                                      ? _nameController.text[0].toUpperCase()
                                      : 'U',
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF6B5B9A),
                                  ),
                                )
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showImageSourceModal,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.electricBlue,
                              shape: BoxShape.circle,
                              border: Border.all(color: cardColor, width: 3),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Name Field
                _buildEnhancedTextField(
                  context: context,
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  label: l10n.fullName,
                  icon: Icons.person,
                  error: _nameError,
                  showError: _nameFieldTouched,
                  validator: (value) {
                    final error = Validators.validateName(value, l10n);
                    // Update state immediately
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted && _nameError != error) {
                        setState(() => _nameError = error);
                      }
                    });
                    return error;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s\-]')),
                    LengthLimitingTextInputFormatter(50),
                  ],
                ),
                const SizedBox(height: 16),

                // Email Field
                _buildEnhancedTextField(
                  context: context,
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  label: l10n.emailAddress,
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  error: _emailError,
                  showError: _emailFieldTouched,
                  validator: (value) {
                    final error = Validators.validateEmail(value, l10n);
                    // Update state immediately
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted && _emailError != error) {
                        setState(() => _emailError = error);
                      }
                    });
                    return error;
                  },
                ),
                const SizedBox(height: 16),

                // Phone Field
                _buildEnhancedTextField(
                  context: context,
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  label: l10n.phoneNumber,
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  error: _phoneError,
                  showError: _phoneFieldTouched,
                  validator: (value) {
                    final error = Validators.validatePhone(value, '+966', l10n);
                    // Update state immediately
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted && _phoneError != error) {
                        setState(() => _phoneError = error);
                      }
                    });
                    return error;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15),
                  ],
                ),
                const SizedBox(height: 32),

                // Save Button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _hasChanges ? AppColors.electricBlue : Colors.grey,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _hasChanges
                        ? [
                            BoxShadow(
                              color: AppColors.electricBlue.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : null,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _isLoading || !_hasChanges
                          ? null
                          : () => _saveProfile(l10n),
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: _isLoading
                            ? const Center(
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.save, color: Colors.white),
                                  const SizedBox(width: 8),
                                  Text(
                                    l10n.saveChanges,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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

  Widget _buildEnhancedTextField({
    required BuildContext context,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? error,
    bool showError = false,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final labelColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final borderColor = isDark ? Colors.grey.shade700 : Colors.grey.shade200;

    final bool hasError = showError && error != null;
    final bool isValid =
        showError && error == null && controller.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            style: TextStyle(color: textColor),
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: labelColor),
              prefixIcon: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.electricBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.electricBlue, size: 20),
              ),
              suffixIcon: controller.text.isNotEmpty
                  ? Icon(
                      isValid
                          ? Icons.check_circle
                          : (hasError ? Icons.error : null),
                      color: isValid
                          ? Colors.green
                          : (hasError ? Colors.red : null),
                      size: 20,
                    )
                  : null,
              filled: true,
              fillColor: cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: hasError ? Colors.red : borderColor,
                  width: hasError ? 2 : 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: hasError ? Colors.red : AppColors.electricBlue,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            ),
            validator: validator,
          ),
        ),
        // Error or success message
        if (showError && controller.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 6),
            child: Row(
              children: [
                Icon(
                  isValid ? Icons.check_circle_outline : Icons.error_outline,
                  size: 14,
                  color: isValid ? Colors.green.shade600 : Colors.red.shade400,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    error ?? l10n.looksGood,
                    style: TextStyle(
                      color:
                          isValid ? Colors.green.shade600 : Colors.red.shade400,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
