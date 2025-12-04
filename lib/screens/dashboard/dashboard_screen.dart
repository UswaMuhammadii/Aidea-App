import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/user_model.dart';
import '../../models/service_model.dart';
import '../../models/booking_model.dart';
import '../invoices/invoice_screen.dart';
import '../notifications/notification_screen.dart';
import '../../models/cart_model.dart';
import '../reviews/review_screen.dart';
import '../orders/order_details_with_worker_screen.dart';
import '../orders/order_tracking_screen.dart';
import '../../services/dummy_data_service.dart';
import '../services/service_listing_screen.dart';
import '../profile/profile_screen.dart';
import '../cart/cart_screen.dart';
import '../../widget/service_image_widget.dart';
import '../../utils/icons_helper.dart';
import '../../gen_l10n/app_localizations.dart';
import 'package:customer_app/screens/maps/map_selection_screen.dart';
import '../../utils/formatting_utils.dart';
import '../../utils/app_colors.dart'; // ✅ Added AppColors import


class DashboardScreen extends StatefulWidget {
  final User user;
  final VoidCallback onLogout;
  final int initialTab;

  const DashboardScreen({
    super.key,
    required this.user,
    required this.onLogout,
    this.initialTab = 0,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  List<ServiceCategory> _categories = [];
  String _selectedAddress = 'Building Sultan Town Lahore Punjab';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _orderTabIndex = 0;
  static bool _hasShownNotificationPopup = false;
  late User _currentUser; // Added for address management

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
    _currentUser = widget.user; // Initialize current user
    _selectedAddress = _getPrimaryAddress(); // Get primary address from user

    // Show notification popup only once per app session
    if (!_hasShownNotificationPopup) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted && !_hasShownNotificationPopup) {
            _hasShownNotificationPopup = true;
            _showNotificationPopup();
          }
        });
      });
    }
  }

  // Get primary address from user's saved addresses
  String _getPrimaryAddress() {
    if (_currentUser.savedAddresses.isEmpty) {
      return _currentUser.address;
    }

    final primaryAddress = _currentUser.savedAddresses.firstWhere(
          (address) => address.isPrimary,
      orElse: () => _currentUser.savedAddresses.first,
    );

    return primaryAddress.fullAddress;
  }

  // Update user when addresses change
  void _updateUser(User updatedUser) {
    setState(() {
      _currentUser = updatedUser;
      _selectedAddress = _getPrimaryAddress();
    });
  }

  void _handleNotificationPermission(AppLocalizations l10n) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text(l10n.notificationsEnabledSuccessfully),
          ],
        ),
        backgroundColor: const Color(0xFF10B981),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showNotificationPopup() {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF14B8A6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_active,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.enableNotifications,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.getRealTimeUpdatesAboutYourBookings,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: subtitleColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        l10n.notNow,
                        style: TextStyle(
                          color: subtitleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7C3AED), Color(0xFF3B82F6)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF7C3AED).withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _handleNotificationPermission(l10n);
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Center(
                              child: Text(
                                l10n.allow,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getUnreadNotificationCount() {
    return globalNotifications.where((n) => n['read'] == false).length;
  }


  void _changeAddress() {
    _showLocationPicker();
  }

  void _openMapSelection() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapSelectionScreen(
          initialAddress: _selectedAddress,
          onLocationSelected: (address, lat, lng) {
            // Handle the location selection directly
            setState(() {
              _selectedAddress = address;
            });

            // Save to addresses
            _saveAddressToProfile(address, lat, lng);

            final l10n = AppLocalizations.of(context)!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$address ${l10n.hasBeenSaved}'),
                backgroundColor: Colors.green,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _saveAddressToProfile(String address, double? lat, double? lng) async {
    // Create a new SavedAddress
    final newAddress = SavedAddress(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Location ${_currentUser.savedAddresses.length + 1}',
      fullAddress: address,
      latitude: lat,
      longitude: lng,
      type: 'other',
      isPrimary: _currentUser.savedAddresses.isEmpty, // First address is primary
      createdAt: DateTime.now(),
    );

    // Update the user with the new address
    final updatedAddresses = [..._currentUser.savedAddresses, newAddress];
    final updatedUser = _currentUser.copyWith(savedAddresses: updatedAddresses);

    // Update the current user
    _updateUser(updatedUser);

    print('Address saved: $address (Lat: $lat, Lng: $lng)');
  }

  void _showLocationPicker() {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: dialogBg,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.electricBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.location_on, color: AppColors.electricBlue),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.selectDeliveryLocation,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textColor)),
                        const SizedBox(height: 4),
                        Text(_selectedAddress,
                            style: TextStyle(
                                fontSize: 14,
                                color: subtitleColor)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: textColor),
                  ),
                ],
              ),
            ),

            // Options List
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Map Selection Option
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.electricBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.map, color: AppColors.electricBlue),
                      ),
                      title: Text(l10n.selectOnMap, style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                      subtitle: Text(l10n.chooseExactLocationOnMap, style: TextStyle(color: subtitleColor)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.pop(context);
                        _openMapSelection();
                      },
                    ),
                    const Divider(),

                    // Current Location Option
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.my_location, color: Colors.blue),
                      ),
                      title: Text(l10n.useCurrentLocation, style: TextStyle(color: textColor)),
                      subtitle: Text(l10n.detectYourCurrentLocation, style: TextStyle(color: subtitleColor)),
                      onTap: () async {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                                SizedBox(width: 12),
                                Text('Getting current location...'),
                              ],
                            ),
                            backgroundColor: AppColors.electricBlue,
                          ),
                        );

                        await Future.delayed(const Duration(seconds: 2));

                        if (mounted) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          setState(() {
                            _selectedAddress = 'Current Location - Lahore, Pakistan';
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$_selectedAddress ${l10n.hasBeenSaved}'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                    ),
                    const Divider(),

                    // Saved Addresses Section
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        l10n.savedAddresses,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),

                    // Home Address
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F172A) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.electricBlue.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.electricBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.home, color: AppColors.electricBlue, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l10n.home,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor)),
                                Text(_selectedAddress,
                                    style: TextStyle(fontSize: 12, color: subtitleColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          const Icon(Icons.check_circle, color: AppColors.electricBlue, size: 20),
                        ],
                      ),
                    ),

                    // Work Address (example)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F172A) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.work, color: Colors.orange, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l10n.work,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor)),
                                Text('Office Building, Gulberg, Lahore',
                                    style: TextStyle(fontSize: 12, color: subtitleColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          Icon(Icons.radio_button_unchecked, color: subtitleColor, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Continue Button
            Container(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.electricBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(l10n.continueText,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } // ✅ Added closing brace for the method
  int get cartItemsCount => globalCart.fold(0, (sum, item) => sum + item.quantity);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_categories.isEmpty) {
      _categories = DummyDataService.getCategories(l10n);
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      drawer: _buildDrawer(l10n),
      body: SafeArea(
        child: Column(
          children: [
            if (_selectedIndex == 0) _buildHeader(l10n),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  _buildHomeTab(l10n),
                  _buildBookingsTab(l10n),
                  InvoiceScreen(user: _currentUser),
                  ReviewScreen(user: _currentUser),
                  ProfileScreen(
                    user: _currentUser,
                    onLogout: widget.onLogout,
                    onUserUpdated: _updateUser, // Added callback for address updates
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(isDark, l10n),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient, // ✅ Same gradient as profile
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepPurple.withOpacity(0.3), // ✅ Use deepPurple
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                ),
                Row(
                  children: [
                    _buildHeaderIcon(Icons.shopping_cart_outlined, cartItemsCount, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(user: _currentUser)))
                          .then((_) => setState(() {}));
                    }),
                    const SizedBox(width: 12),
                    _buildHeaderIcon(Icons.notifications_outlined, _getUnreadNotificationCount(), () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()
                      ))
                          .then((_) => setState(() {}));
                    }),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.business,
                            color: AppColors.electricBlue,
                            size: 24,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HandyMan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Home Services',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Hello, ${_currentUser.name}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: _changeAddress,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _selectedAddress,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon, int count, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          if (count > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Text(
                  count.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(bool isDark, AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(Icons.home_rounded, l10n.home, 0, isDark),
              _buildBottomNavItem(Icons.shopping_bag_rounded, l10n.orders, 1, isDark),
              _buildBottomNavItem(Icons.receipt_long_rounded, l10n.invoices, 2, isDark),
              _buildBottomNavItem(Icons.star_rounded, l10n.reviews, 3, isDark),
              _buildBottomNavItem(Icons.person_rounded, l10n.profile, 4, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index, bool isDark) {
    final isActive = _selectedIndex == index;
    final inactiveColor = isDark ? Colors.grey.shade500 : Colors.grey.shade600;

    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.electricBlue.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? AppColors.electricBlue : inactiveColor, size: 26),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.electricBlue : inactiveColor,
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(AppLocalizations l10n) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Profile Section with Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0EA5E9),  // Electric Blue
                    Color(0xFF14B8A6),  // Teal
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 32,
                            color: AppColors.electricBlue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _currentUser.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _currentUser.email,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Menu Items Section - White Background
            Expanded(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      _buildDrawerItemWhite(Icons.home, l10n.home, () {
                        Navigator.pop(context);
                        setState(() => _selectedIndex = 0);
                      }, null),
                      _buildDrawerItemWhite(Icons.shopping_bag_rounded, l10n.myOrders, () {
                        Navigator.pop(context);
                        setState(() => _selectedIndex = 1);
                      }, null),
                      _buildDrawerItemWhite(Icons.receipt_long_rounded, l10n.invoices, () {
                        Navigator.pop(context);
                        setState(() => _selectedIndex = 2);
                      }, null),
                      _buildDrawerItemWhite(Icons.star_rounded, l10n.reviews, () {
                        Navigator.pop(context);
                        setState(() => _selectedIndex = 3);
                      }, null),
                      _buildDrawerItemWhite(Icons.shopping_cart, l10n.cart, () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartScreen(user: _currentUser),
                          ),
                        ).then((_) => setState(() {}));
                      }, cartItemsCount > 0 ? cartItemsCount.toString() : null),
                      _buildDrawerItemWhite(Icons.person, l10n.profile, () {
                        Navigator.pop(context);
                        setState(() => _selectedIndex = 4);
                      }, null),
                    ],
                  ),
                ),
              ),
            ),

            // Logout Section - White Background
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  const Divider(color: Colors.grey, height: 1),
                  _buildDrawerItemWhite(Icons.logout, l10n.logout, () {
                    print('🚪 Logout button tapped');
                    Navigator.pop(context);
                    print('🔄 Calling onLogout callback');
                    widget.onLogout();
                    print('✅ Logout callback called');
                  }, null),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItemWhite(IconData icon, String title, VoidCallback onTap, String? badge) {
    return ListTile(
      leading: Icon(icon, color: AppColors.electricBlue, size: 22),
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (badge != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      onTap: onTap,
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, String? badge) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 22),
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (badge != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      onTap: onTap,
    );
  }

  Widget _buildHomeTab(AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.ourServices, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor)),
            const SizedBox(height: 12),

            // Grid Layout for Categories - FIXED OVERFLOW
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.88,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceListingScreen(
                          categoryName: category.name,
                          user: _currentUser,
                        ),
                      ),
                    ).then((_) => setState(() {}));
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image section - 60% of card height
                        Expanded(
                          flex: 60,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: ServiceImageWidget(
                              imageUrl: DummyDataService.getCategoryImage(category.name),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Bottom section - 40% of card height
                        Expanded(
                          flex: 40,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Top row with icon and arrow
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: AppColors.electricBlue.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Icon(
                                        IconHelper.getCategoryIcon(category.name).icon,
                                        color: AppColors.electricBlue,
                                        size: 14,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.electricBlue,
                                      size: 12,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                // Text section - wrapped in Flexible
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        category.name,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                          height: 1.2,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${category.services.length} services',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: subtitleColor,
                                          height: 1.2,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingsTab(AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final shadowOpacity = isDark ? 0.3 : 0.08;

    final bookings = DummyDataService.getUserBookings(_currentUser.id);
    final activeBookings = bookings.where((b) =>
    b.status == BookingStatus.pending ||
        b.status == BookingStatus.confirmed ||
        b.status == BookingStatus.inProgress
    ).toList();
    final previousBookings = bookings.where((b) =>
    b.status == BookingStatus.completed ||
        b.status == BookingStatus.cancelled
    ).toList();

    Map<String, List<Booking>> groupBookings(List<Booking> bookingList) {
      Map<String, List<Booking>> grouped = {};
      for (var booking in bookingList) {
        String key = '${booking.bookingDate}_${booking.bookingTime}';
        if (!grouped.containsKey(key)) grouped[key] = [];
        grouped[key]!.add(booking);
      }
      return grouped;
    }

    final displayBookings = _orderTabIndex == 0 ? activeBookings : previousBookings;
    final groupedBookings = groupBookings(displayBookings);

    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          Container(
            color: cardColor,
            child: Row(
              children: [
                Expanded(child: _buildOrderTab(l10n.active, 0, activeBookings.length, l10n)),
                Expanded(child: _buildOrderTab(l10n.previous, 1, previousBookings.length, l10n)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (groupedBookings.isEmpty)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.electricBlue.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.receipt_long_outlined, size: 64, color: AppColors.electricBlue.withOpacity(0.5)),
                            ),
                            const SizedBox(height: 20),
                            Text(_orderTabIndex == 0 ? l10n.noActiveOrders : l10n.noPreviousOrders, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
                            const SizedBox(height: 8),
                            Text(_orderTabIndex == 0 ? l10n.bookYourFirstServiceToday : l10n.yourCompletedOrdersWillAppearHere, style: TextStyle(fontSize: 14, color: subtitleColor)),
                            if (_orderTabIndex == 0) ...[
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () => setState(() => _selectedIndex = 0),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.electricBlue,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: Text(l10n.bookNow, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ],
                        ),
                      ),
                    )
                  else
                    ...groupedBookings.entries.map((entry) {
                      final bookingGroup = entry.value;
                      final firstBooking = bookingGroup.first;
                      final totalPrice = bookingGroup.fold<double>(0.0, (sum, booking) => sum + booking.totalPrice);

                      bool hasTechnician = firstBooking.status == BookingStatus.confirmed ||
                          firstBooking.status == BookingStatus.inProgress;
                      bool isCompleted = firstBooking.status == BookingStatus.completed ||
                          firstBooking.status == BookingStatus.cancelled;

                      String getStatusDisplayText() {
                        if (firstBooking.status == BookingStatus.pending) return 'Booking Done';
                        if (firstBooking.status == BookingStatus.confirmed) return 'Technician Assigned';
                        if (firstBooking.status == BookingStatus.inProgress) return 'Work Started';
                        if (firstBooking.status == BookingStatus.completed) return 'Work Done';
                        if (firstBooking.status == BookingStatus.cancelled) return l10n.cancelled;
                        return firstBooking.statusText;
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(shadowOpacity), blurRadius: 15, offset: const Offset(0, 5))],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
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
                                          firstBooking.statusColor.withOpacity(0.2),
                                          firstBooking.statusColor.withOpacity(0.1)
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      firstBooking.status == BookingStatus.completed
                                          ? Icons.check_circle
                                          : firstBooking.status == BookingStatus.cancelled
                                          ? Icons.cancel
                                          : firstBooking.status == BookingStatus.inProgress
                                          ? Icons.build
                                          : firstBooking.status == BookingStatus.confirmed
                                          ? Icons.person_pin
                                          : Icons.schedule,
                                      color: firstBooking.statusColor,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bookingGroup.length > 1 ? '${bookingGroup.length} Services Booked' : firstBooking.service?.name ?? 'Service',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: firstBooking.statusColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            getStatusDisplayText(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: firstBooking.statusColor
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              if (hasTechnician) ...[
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                                  ),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.blue,
                                          child: Icon(Icons.person, color: Colors.white, size: 14),
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            'Technician: Sarish Naz',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(Icons.verified, color: Colors.blue, size: 14),
                                      ],
                                    ),
                                  ),
                                ),
                              ],

                              if (bookingGroup.length > 1) ...[
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isDark ? const Color(0xFF0F172A) : Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Services:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textColor)),
                                      const SizedBox(height: 8),
                                      ...bookingGroup.map((booking) => Padding(
                                        padding: const EdgeInsets.only(bottom: 4),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 4,
                                              height: 4,
                                              decoration: const BoxDecoration(color: AppColors.electricBlue, shape: BoxShape.circle),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text('${booking.service?.name ?? 'Service'} (${booking.quantity}x)', style: TextStyle(fontSize: 12, color: textColor)),
                                            ),
                                            Text(FormattingUtils.formatCurrency(booking.totalPrice, l10n, Localizations.localeOf(context)), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.electricBlue)),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ],

                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF0F172A) : Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Date & Time', style: TextStyle(fontSize: 12, color: subtitleColor)),
                                        Text(
                                          '${DateFormat('MMM d, y').format(firstBooking.bookingDate)} at ${DateFormat('h:mm a').format(firstBooking.bookingTime)}',
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textColor),
                                        ),
                                      ],
                                    ),
                                    const Divider(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(FormattingUtils.formatCurrency(totalPrice, l10n, Localizations.localeOf(context)), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.electricBlue)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              if (!isCompleted) ...[
                                const SizedBox(height: 12),
                                InkWell(
                                  onTap: () {
                                    if (firstBooking.status == BookingStatus.pending) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OrderTrackingScreen(
                                            user: _currentUser,
                                            booking: firstBooking,
                                          ),
                                        ),
                                      ).then((_) => setState(() {}));
                                    } else if (firstBooking.status == BookingStatus.confirmed ||
                                        firstBooking.status == BookingStatus.inProgress) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OrderDetailsWithWorkerScreen(
                                            user: _currentUser,
                                            booking: firstBooking,
                                          ),
                                        ),
                                      ).then((_) => setState(() {}));
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      color: AppColors.electricBlue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          firstBooking.status == BookingStatus.pending
                                              ? Icons.location_on
                                              : Icons.person_search,
                                          color: AppColors.electricBlue,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          firstBooking.status == BookingStatus.pending
                                              ? l10n.trackOrder
                                              : l10n.viewTechnicianDetails,
                                          style: const TextStyle(
                                            color: AppColors.electricBlue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.arrow_forward,
                                          color: AppColors.electricBlue,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTab(String title, int index, int count, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isActive = _orderTabIndex == index;
    final inactiveColor = isDark ? Colors.grey.shade500 : Colors.grey.shade600;

    return InkWell(
      onTap: () => setState(() => _orderTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: isActive ? AppColors.electricBlue : Colors.transparent, width: 3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? AppColors.electricBlue : inactiveColor,
              ),
            ),
            if (count > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.electricBlue : (isDark ? Colors.grey.shade700 : Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(count.toString(), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void switchToOrdersTab() {
    setState(() {
      _selectedIndex = 1;
    });
  }
}