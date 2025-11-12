import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../gen_l10n/app_localizations.dart';

const Color backgroundColor = Color(0xFFF8F9FA);
const Color surfaceColor = Colors.white;
const Color textColor = Colors.black87;
const Color subtitleColor = Colors.grey;

const Color darkBackgroundColor = Color(0xFF0F172A);
const Color darkSurfaceColor = Color(0xFF1E293B);
const Color darkTextColor = Colors.white;
const Color darkSubtitleColor = Colors.grey;

class AddressesScreen extends StatefulWidget {
  final User user;

  const AddressesScreen({
    super.key,
    required this.user,
  });

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  late TextEditingController _addressController;
  bool _isEditing = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.user.address);
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _saveAddress(AppLocalizations l10n) async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isSaving = false;
      _isEditing = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.addressUpdatedSuccessfully),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(l10n.savedAddresses),
        centerTitle: true,
        backgroundColor: cardColor,
        foregroundColor: textColor,
        elevation: 0,
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => _isEditing = true),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    cardColor,
                    isDark ? Colors.grey.shade800 : Colors.grey.shade50,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF6B5B9A).withValues(alpha: 0.1),
                              const Color(0xFF7C3AED).withValues(alpha: 0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.home,
                          color: Color(0xFF6B5B9A),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.homeAddress,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                      if (_isEditing)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(l10n.editing,
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  if (_isEditing)
                    TextField(
                      controller: _addressController,
                      maxLines: 3,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        hintText: l10n.enterYourAddress,
                        filled: true,
                        fillColor: isDark ? const Color(0xFF0F172A) : Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF6B5B9A),
                            width: 2,
                          ),
                        ),
                      ),
                    )
                  else
                    Text(
                      widget.user.address,
                      style: TextStyle(
                        fontSize: 14,
                        color: subtitleColor,
                        height: 1.5,
                      ),
                    ),

                  if (_isEditing) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              _addressController.text = widget.user.address;
                              setState(() => _isEditing = false);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                              ),
                            ),
                            child: Text(l10n.cancel),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6B5B9A), Color(0xFF7C3AED)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ElevatedButton(
                              onPressed: _isSaving ? null : () => _saveAddress(l10n),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: _isSaving
                                  ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                                  : Text(l10n.save),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF6B5B9A).withValues(alpha: 0.3),
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Add new address feature coming soon!'),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_circle_outline,
                          color: Color(0xFF6B5B9A),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          l10n.addNewAddress,
                          style: TextStyle(
                            color: const Color(0xFF6B5B9A),
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
    );
  }
}