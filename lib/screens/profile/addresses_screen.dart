import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../gen_l10n/app_localizations.dart';
import '../maps/map_selection_screen.dart';

class AddressesScreen extends StatefulWidget {
  final User user;
  final Function(User)? onUserUpdated; // Callback to update user in parent

  const AddressesScreen({
    super.key,
    required this.user,
    this.onUserUpdated,
  });

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  late List<SavedAddress> _addresses;
  String? _editingAddressId;
  final Map<String, TextEditingController> _titleControllers = {};

  @override
  void initState() {
    super.initState();
    _addresses = List.from(widget.user.savedAddresses);

    // If no addresses exist, add the default address from user
    if (_addresses.isEmpty && widget.user.address.isNotEmpty) {
      _addresses.add(
        SavedAddress(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: 'Home',
          fullAddress: widget.user.address,
          type: 'home',
          isPrimary: true,
          createdAt: DateTime.now(),
        ),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _titleControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _openMapSelection({SavedAddress? addressToEdit}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapSelectionScreen(
          initialAddress: addressToEdit?.fullAddress,
          onLocationSelected: (address, lat, lng) {
            _handleLocationSelected(address, lat, lng, addressToEdit);
          },
        ),
      ),
    );
  }

  void _handleLocationSelected(
      String address,
      double? latitude,
      double? longitude,
      SavedAddress? existingAddress,
      ) {
    setState(() {
      if (existingAddress != null) {
        // Update existing address
        final index = _addresses.indexWhere((a) => a.id == existingAddress.id);
        if (index != -1) {
          _addresses[index] = existingAddress.copyWith(
            fullAddress: address,
            latitude: latitude,
            longitude: longitude,
          );
        }
      } else {
        // Add new address
        final newAddress = SavedAddress(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _getNextAddressTitle(),
          fullAddress: address,
          latitude: latitude,
          longitude: longitude,
          type: 'other',
          isPrimary: _addresses.isEmpty,
          createdAt: DateTime.now(),
        );
        _addresses.add(newAddress);
      }

      _updateUser();
    });

    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          existingAddress != null
              ? l10n.addressUpdatedSuccessfully
              : 'Address added successfully!',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  String _getNextAddressTitle() {
    final types = ['Home', 'Work', 'Other'];
    final usedTitles = _addresses.map((a) => a.title).toSet();

    for (var type in types) {
      if (!usedTitles.contains(type)) {
        return type;
      }
    }

    return 'Address ${_addresses.length + 1}';
  }

  void _deleteAddress(String addressId) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Address'),
        content: Text('Are you sure you want to delete this address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _addresses.removeWhere((a) => a.id == addressId);
                _updateUser();
              });
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Address deleted successfully!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _setPrimaryAddress(String addressId) {
    setState(() {
      // Set all addresses to non-primary
      for (var i = 0; i < _addresses.length; i++) {
        _addresses[i] = _addresses[i].copyWith(isPrimary: false);
      }

      // Set selected address as primary
      final index = _addresses.indexWhere((a) => a.id == addressId);
      if (index != -1) {
        _addresses[index] = _addresses[index].copyWith(isPrimary: true);
      }

      _updateUser();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Primary address updated!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _updateAddressTitle(String addressId, String newTitle) {
    setState(() {
      final index = _addresses.indexWhere((a) => a.id == addressId);
      if (index != -1) {
        _addresses[index] = _addresses[index].copyWith(title: newTitle);
        _editingAddressId = null;
      }
      _updateUser();
    });
  }

  void _updateUser() {
    if (widget.onUserUpdated != null) {
      final updatedUser = widget.user.copyWith(savedAddresses: _addresses);
      widget.onUserUpdated!(updatedUser);
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // List of saved addresses
            if (_addresses.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Icon(
                        Icons.location_off,
                        size: 64,
                        color: subtitleColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No saved addresses yet',
                        style: TextStyle(
                          fontSize: 16,
                          color: subtitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ..._addresses.map((address) => _buildAddressCard(
                address,
                isDark,
                cardColor,
                textColor,
                subtitleColor,
                l10n,
              )),

            const SizedBox(height: 16),

            // Add New Address Button
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
                  onTap: () => _openMapSelection(),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_location_alt,
                          color: Color(0xFF6B5B9A),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          l10n.addNewAddress,
                          style: const TextStyle(
                            color: Color(0xFF6B5B9A),
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

  Widget _buildAddressCard(
      SavedAddress address,
      bool isDark,
      Color cardColor,
      Color textColor,
      Color subtitleColor,
      AppLocalizations l10n,
      ) {
    final isEditing = _editingAddressId == address.id;

    if (!_titleControllers.containsKey(address.id)) {
      _titleControllers[address.id] = TextEditingController(text: address.title);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        border: address.isPrimary
            ? Border.all(color: const Color(0xFF6B5B9A), width: 2)
            : null,
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
                child: Icon(
                  _getAddressIcon(address.type),
                  color: const Color(0xFF6B5B9A),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),

              // Editable title
              Expanded(
                child: isEditing
                    ? TextField(
                  controller: _titleControllers[address.id],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onSubmitted: (value) {
                    _updateAddressTitle(address.id, value);
                  },
                )
                    : Text(
                  address.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),

              // Edit title button
              IconButton(
                icon: Icon(
                  isEditing ? Icons.check : Icons.edit,
                  size: 20,
                  color: const Color(0xFF6B5B9A),
                ),
                onPressed: () {
                  if (isEditing) {
                    _updateAddressTitle(
                      address.id,
                      _titleControllers[address.id]!.text,
                    );
                  } else {
                    setState(() => _editingAddressId = address.id);
                  }
                },
              ),

              // Primary badge
              if (address.isPrimary)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Primary',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Address text
          Text(
            address.fullAddress,
            style: TextStyle(
              fontSize: 14,
              color: subtitleColor,
              height: 1.5,
            ),
          ),

          // Coordinates if available
          if (address.latitude != null && address.longitude != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Lat: ${address.latitude!.toStringAsFixed(6)}, Lng: ${address.longitude!.toStringAsFixed(6)}',
                style: TextStyle(
                  fontSize: 12,
                  color: subtitleColor.withValues(alpha: 0.7),
                ),
              ),
            ),

          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              // Set Primary
              if (!address.isPrimary)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _setPrimaryAddress(address.id),
                    icon: const Icon(Icons.star_outline, size: 18),
                    label: const Text('Set Primary'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF6B5B9A),
                      side: const BorderSide(color: Color(0xFF6B5B9A)),
                    ),
                  ),
                ),

              if (!address.isPrimary) const SizedBox(width: 8),

              // Edit on Map
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _openMapSelection(addressToEdit: address),
                  icon: const Icon(Icons.map, size: 18),
                  label: const Text('Edit'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Delete
              IconButton(
                onPressed: () => _deleteAddress(address.id),
                icon: const Icon(Icons.delete_outline),
                color: Colors.red,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.red.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getAddressIcon(String type) {
    switch (type.toLowerCase()) {
      case 'home':
        return Icons.home;
      case 'work':
        return Icons.business;
      case 'other':
      default:
        return Icons.location_on;
    }
  }
}