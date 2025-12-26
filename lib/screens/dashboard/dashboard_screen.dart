import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../models/service_model.dart';
import '../../models/booking_model.dart';
import '../invoices/invoice_screen.dart';
import '../notifications/notification_screen.dart';
import '../../models/cart_model.dart';
import '../reviews/review_screen.dart';

import '../orders/order_tracking_screen.dart';
import '../../services/dummy_data_service.dart';
import '../../services/firestore_service.dart';
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
  final Function(Locale)? onLanguageChanged;
  final int initialTab;

  const DashboardScreen({
    super.key,
    required this.user,
    required this.onLogout,
    this.onLanguageChanged,
    this.initialTab = 0,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  List<ServiceCategory> _categories = [];
  List<Service> _allServices = []; // Added for lookup
  String _selectedAddress = 'Building Sultan Town Lahore Punjab';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _orderTabIndex = 0;
  static bool _hasShownNotificationPopup = false;
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
    _currentUser = widget.user;
    _selectedAddress = _getPrimaryAddress();

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

    _loadData(); // Renamed and expanded
  }

  Future<void> _loadData() async {
    final firestoreService = FirestoreService();
    try {
      final categoriesFuture = firestoreService.getCategories();
      final servicesFuture = firestoreService.getServices(); // Fetch flat list

      final results = await Future.wait([categoriesFuture, servicesFuture]);

      if (mounted) {
        setState(() {
          _categories = results[0] as List<ServiceCategory>;
          _allServices = results[1] as List<Service>;
        });
      }
    } catch (e) {
      print('Error loading data: $e');
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

  Future<void> _saveAddressToProfile(
      String address, double? lat, double? lng) async {
    // Create a new SavedAddress
    final newAddress = SavedAddress(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Location ${_currentUser.savedAddresses.length + 1}',
      fullAddress: address,
      latitude: lat,
      longitude: lng,
      type: 'other',
      isPrimary:
          _currentUser.savedAddresses.isEmpty, // First address is primary
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
                    child: const Icon(Icons.location_on,
                        color: AppColors.electricBlue),
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
                            style:
                                TextStyle(fontSize: 14, color: subtitleColor)),
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
                        child: const Icon(Icons.map,
                            color: AppColors.electricBlue),
                      ),
                      title: Text(l10n.selectOnMap,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: textColor)),
                      subtitle: Text(l10n.chooseExactLocationOnMap,
                          style: TextStyle(color: subtitleColor)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.pop(context);
                        _openMapSelection();
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
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF0F172A)
                            : Colors.grey.shade100,
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
                            child: const Icon(Icons.home,
                                color: AppColors.electricBlue, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l10n.home,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: textColor)),
                                Text(_selectedAddress,
                                    style: TextStyle(
                                        fontSize: 12, color: subtitleColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          const Icon(Icons.check_circle,
                              color: AppColors.electricBlue, size: 20),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(l10n.continueText,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } // ✅ Added closing brace for the method

  int get cartItemsCount =>
      globalCart.fold(0, (sum, item) => sum + item.quantity);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Categories loaded via Firestore in initState

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);

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
                    onUserUpdated:
                        _updateUser, // Added callback for address updates
                    onLanguageChanged: widget.onLanguageChanged,
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
                    _buildHeaderIcon(
                        Icons.shopping_cart_outlined, cartItemsCount, () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CartScreen(user: _currentUser)))
                          .then((_) => setState(() {}));
                    }),
                    const SizedBox(width: 12),
                    _buildHeaderIcon(Icons.notifications_outlined,
                        _getUnreadNotificationCount(), () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationsScreen()))
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on,
                        color: Colors.white, size: 18),
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
                    const Icon(Icons.keyboard_arrow_down,
                        color: Colors.white, size: 18),
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
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
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
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
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
              _buildBottomNavItem(
                  Icons.shopping_bag_rounded, l10n.orders, 1, isDark),
              _buildBottomNavItem(
                  Icons.receipt_long_rounded, l10n.invoices, 2, isDark),
              _buildBottomNavItem(Icons.star_rounded, l10n.reviews, 3, isDark),
              _buildBottomNavItem(
                  Icons.person_rounded, l10n.profile, 4, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
      IconData icon, String label, int index, bool isDark) {
    final isActive = _selectedIndex == index;
    final inactiveColor = isDark ? Colors.grey.shade500 : Colors.grey.shade600;

    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.electricBlue.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: isActive ? AppColors.electricBlue : inactiveColor,
                size: 26),
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
                    Color(0xFF0EA5E9), // Electric Blue
                    Color(0xFF14B8A6), // Teal
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                      _buildDrawerItemWhite(
                          Icons.shopping_bag_rounded, l10n.myOrders, () {
                        Navigator.pop(context);
                        setState(() => _selectedIndex = 1);
                      }, null),
                      _buildDrawerItemWhite(
                          Icons.receipt_long_rounded, l10n.invoices, () {
                        Navigator.pop(context);
                        setState(() => _selectedIndex = 2);
                      }, null),
                      _buildDrawerItemWhite(Icons.star_rounded, l10n.reviews,
                          () {
                        Navigator.pop(context);
                        setState(() => _selectedIndex = 3);
                      }, null),
                      _buildDrawerItemWhite(Icons.shopping_cart, l10n.cart, () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CartScreen(user: _currentUser),
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

  Widget _buildDrawerItemWhite(
      IconData icon, String title, VoidCallback onTap, String? badge) {
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
            Text(l10n.ourServices,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
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
                          category: category,
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
                              imageUrl: (category.imageUrl != null &&
                                      category.imageUrl!.isNotEmpty)
                                  ? category.imageUrl!
                                  : DummyDataService.getCategoryImage(
                                      category.name),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Bottom section - 40% of card height
                        Expanded(
                          flex: 40,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Top row with icon and arrow
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: AppColors.electricBlue
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Icon(
                                        IconHelper.getCategoryIcon(
                                                category.name)
                                            .icon,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        Localizations.localeOf(context)
                                                        .languageCode ==
                                                    'ar' &&
                                                category.nameArabic.isNotEmpty
                                            ? category.nameArabic
                                            : category.name,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
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
    final backgroundColor =
        isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    final firestoreService = FirestoreService();

    return StreamBuilder<List<Booking>>(
      stream: firestoreService.getUserBookings(_currentUser.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.electricBlue,
            ),
          );
        }

        if (snapshot.hasError) {
          debugPrint(
              'Error loading bookings: ${snapshot.error}'); // ✅ Log the error
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Error loading bookings',
                  style: TextStyle(color: textColor),
                ),
                // Optional: Show error details in debug mode
                // Text(snapshot.error.toString(), style: TextStyle(color: Colors.red, fontSize: 10)),
              ],
            ),
          );
        }

        final bookings = snapshot.data ?? [];
        final activeBookings = bookings
            .where((b) =>
                b.status == BookingStatus.pending ||
                b.status == BookingStatus.assigned ||
                b.status == BookingStatus.accepted ||
                b.status == BookingStatus.inProgress)
            .toList();
        final previousBookings = bookings
            .where((b) =>
                b.status == BookingStatus.completed ||
                b.status == BookingStatus.cancelled ||
                b.status == BookingStatus.postponed)
            .toList();

        Map<String, List<Booking>> groupBookings(List<Booking> bookingList) {
          Map<String, List<Booking>> grouped = {};
          for (var booking in bookingList) {
            String key = '${booking.bookingDate}_${booking.bookingTime}';
            if (!grouped.containsKey(key)) grouped[key] = [];
            grouped[key]!.add(booking);
          }
          return grouped;
        }

        final displayBookings =
            _orderTabIndex == 0 ? activeBookings : previousBookings;
        final groupedBookings = groupBookings(displayBookings);

        return Container(
          color: backgroundColor,
          child: Column(
            children: [
              Container(
                color: cardColor,
                child: Row(
                  children: [
                    Expanded(
                        child: _buildOrderTab(
                            l10n.active, 0, activeBookings.length, l10n)),
                    Expanded(
                        child: _buildOrderTab(
                            l10n.previous, 1, previousBookings.length, l10n)),
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
                        _buildEmptyState(
                            l10n, cardColor, textColor, subtitleColor)
                      else
                        ...groupedBookings.values.map(
                            (group) => _buildBookingGroupCard(group, l10n)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n, Color cardColor,
      Color textColor, Color subtitleColor) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5))
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.electricBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.receipt_long_outlined,
                  size: 64, color: AppColors.electricBlue.withOpacity(0.5)),
            ),
            const SizedBox(height: 20),
            Text(
                _orderTabIndex == 0
                    ? l10n.noActiveOrders
                    : l10n.noPreviousOrders,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
            const SizedBox(height: 8),
            Text(
                _orderTabIndex == 0
                    ? l10n.bookYourFirstServiceToday
                    : l10n.yourCompletedOrdersWillAppearHere,
                style: TextStyle(fontSize: 14, color: subtitleColor),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingGroupCard(
      List<Booking> bookingGroup, AppLocalizations l10n) {
    if (bookingGroup.isEmpty) return const SizedBox();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    final firstBooking = bookingGroup.first;
    final totalPrice = bookingGroup.fold(0.0, (sum, b) => sum + b.totalPrice);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            final localizedName = _getLocalizedServiceName(firstBooking, l10n);
            if (firstBooking.status == BookingStatus.pending ||
                firstBooking.status == BookingStatus.assigned ||
                firstBooking.status == BookingStatus.accepted ||
                firstBooking.status == BookingStatus.inProgress) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderTrackingScreen(
                    user: _currentUser,
                    booking: firstBooking,
                    localizedServiceName: localizedName,
                  ),
                ),
              ).then((_) => setState(() {}));
            } else if (firstBooking.status == BookingStatus.completed) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderTrackingScreen(
                    user: _currentUser,
                    booking: firstBooking,
                    localizedServiceName: localizedName,
                  ),
                ),
              ).then((_) => setState(() {}));
            }
          },
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
                        _getStatusIcon(firstBooking.status),
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
                            bookingGroup.length > 1
                                ? '${bookingGroup.length} ${l10n.servicesBooked}'
                                : _getLocalizedServiceName(firstBooking, l10n),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textColor),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: firstBooking.statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _getStatusText(firstBooking.status, l10n),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: firstBooking.statusColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (bookingGroup.length > 1) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF0F172A)
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${l10n.services}:',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: textColor)),
                        const SizedBox(height: 8),
                        ...bookingGroup.map((booking) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                children: [
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                        color: AppColors.electricBlue,
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                        '${_getLocalizedServiceName(booking, l10n)} (${FormattingUtils.formatNumber(booking.quantity, Localizations.localeOf(context))}x)',
                                        style: TextStyle(
                                            fontSize: 12, color: textColor)),
                                  ),
                                  Text(
                                      FormattingUtils.formatCurrency(
                                          booking.totalPrice,
                                          l10n,
                                          Localizations.localeOf(context)),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.electricBlue)),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '${FormattingUtils.formatDateShort(context, firstBooking.bookingDate)} ${l10n.localeName == 'ar' ? '' : 'at'} ${firstBooking.bookingTime}',
                        style: TextStyle(color: subtitleColor, fontSize: 13)),
                    Text(
                        FormattingUtils.formatCurrency(
                            totalPrice, l10n, Localizations.localeOf(context)),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.electricBlue)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getStatusText(BookingStatus status, AppLocalizations l10n) {
    switch (status) {
      case BookingStatus.pending:
        return l10n.pending;
      case BookingStatus.assigned:
        return l10n.technicianAssigned;
      case BookingStatus.accepted:
        return l10n.confirmed;
      case BookingStatus.inProgress:
        return l10n.inProgress;
      case BookingStatus.completed:
        return l10n.completed;
      case BookingStatus.postponed:
        return 'Postponed';
      case BookingStatus.cancelled:
        return l10n.cancelled;
    }
  }

  String _getLocalizedServiceName(Booking booking, AppLocalizations l10n) {
    // 1. If locale is not Arabic, return English name
    if (l10n.localeName != 'ar') {
      return booking.serviceName.isNotEmpty
          ? booking.serviceName
          : l10n.service;
    }

    // 2. If Booking has Arabic name directly, use it
    if (booking.serviceNameArabic != null &&
        booking.serviceNameArabic!.isNotEmpty) {
      return booking.serviceNameArabic!;
    }

    // 3. Fallback: Lookup in loaded services (More reliable)
    try {
      final service = _allServices.firstWhere(
        (s) => s.id == booking.serviceId,
        orElse: () => Service(
            id: '',
            name: '',
            description: '',
            price: 0,
            category: '',
            features: []), // Dummy
      );

      if (service.id.isNotEmpty && service.nameArabic.isNotEmpty) {
        return service.nameArabic;
      }
    } catch (e) {
      debugPrint('Error looking up localized name in allServices: $e');
    }

    // 4. Fallback: Lookup in loaded categories (Legacy)
    try {
      for (final category in _categories) {
        for (final service in category.services) {
          if (service.id == booking.serviceId) {
            if (service.nameArabic.isNotEmpty) {
              return service.nameArabic;
            }
            break; // Found service but no Arabic name
          }
        }
      }
    } catch (e) {
      debugPrint('Error looking up localized name: $e');
    }

    // 5. Ultimate fallback
    return booking.serviceName.isNotEmpty ? booking.serviceName : l10n.service;
  }

  IconData _getStatusIcon(BookingStatus status) {
    switch (status) {
      case BookingStatus.completed:
        return Icons.check_circle;
      case BookingStatus.cancelled:
        return Icons.cancel;
      case BookingStatus.inProgress:
        return Icons.build;
      case BookingStatus.accepted:
        return Icons.person_pin;
      default:
        return Icons.schedule;
    }
  }

  Widget _buildOrderTab(
      String title, int index, int count, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isActive = _orderTabIndex == index;
    final inactiveColor = isDark ? Colors.grey.shade500 : Colors.grey.shade600;

    return InkWell(
      onTap: () => setState(() => _orderTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: isActive ? AppColors.electricBlue : Colors.transparent,
                  width: 3)),
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
                  color: isActive
                      ? AppColors.electricBlue
                      : (isDark ? Colors.grey.shade700 : Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(count.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
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
