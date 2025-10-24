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

class DashboardColors {
  static const deepPurple = Color(0xFF7C3AED);
  static const electricBlue = Color(0xFF3B82F6);
  static const accentTeal = Color(0xFF14B8A6);

  static const headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF7C3AED),
      Color(0xFF6366F1),
      Color(0xFF3B82F6),
      Color(0xFF14B8A6),
    ],
  );

  static const drawerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF9F7AEA),
      Color(0xFF8B5CF6),
      Color(0xFF7C3AED),
      Color(0xFF6366F1),
      Color(0xFF60A5FA),
    ],
  );
}

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
  late int _selectedIndex;
  late List<ServiceCategory> _categories;
  String _selectedAddress = 'Building Sultan Town Lahore Punjab';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _orderTabIndex = 0;
  static bool _hasShownNotificationPopup = false; // Static to persist across rebuilds

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
    _categories = DummyDataService.getCategories();

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

  void _handleNotificationPermission() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text('Notifications enabled successfully!'),
          ],
        ),
        backgroundColor: Color(0xFF10B981),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
      ),
    );
  }

  void _showNotificationPopup() {
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
                'Enable Notifications',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Get real-time updates about your bookings, technician assignments, and service completion.',
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
                        'Not Now',
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
                            _handleNotificationPermission();
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Center(
                              child: Text(
                                'Allow',
                                style: TextStyle(
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
    return globalNotifications.where((n) => !n.isRead).length;
  }

  void _changeAddress() {
    _showLocationPicker();
  }

  void _showLocationPicker() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: dialogBg,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: DashboardColors.deepPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.location_on, color: DashboardColors.deepPurple),
                  ),
                  const SizedBox(width: 12),
                  Text('Home', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: textColor),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(_selectedAddress, style: TextStyle(fontSize: 14, color: subtitleColor)),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.my_location, color: DashboardColors.deepPurple),
                title: Text('Use my current location', style: TextStyle(color: textColor)),
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Getting current location...'),
                      backgroundColor: DashboardColors.deepPurple,
                    ),
                  );
                },
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0F172A) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_city, size: 20, color: textColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lahore', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                          Text(_selectedAddress, style: TextStyle(fontSize: 12, color: subtitleColor), maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DashboardColors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Continue', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int get cartItemsCount => globalCart.fold(0, (sum, item) => sum + item.quantity);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      drawer: _buildDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            if (_selectedIndex == 0) _buildHeader(),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  _buildHomeTab(),
                  _buildBookingsTab(),
                  InvoiceScreen(user: widget.user),
                  ReviewScreen(user: widget.user),
                  ProfileScreen(user: widget.user, onLogout: widget.onLogout),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: DashboardColors.headerGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: DashboardColors.deepPurple.withOpacity(0.3),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(user: widget.user)))
                          .then((_) => setState(() {}));
                    }),
                    const SizedBox(width: 12),
                    _buildHeaderIcon(Icons.notifications_outlined, _getUnreadNotificationCount(), () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(user: widget.user)))
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
                      'assets/images/Aidea_logo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.business,
                            color: DashboardColors.deepPurple,
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
                      'Aidea Technology',
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
              'Hello, ${widget.user.name}',
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

  Widget _buildBottomNav(bool isDark) {
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
              _buildBottomNavItem(Icons.home_rounded, 'Home', 0, isDark),
              _buildBottomNavItem(Icons.shopping_bag_rounded, 'Orders', 1, isDark),
              _buildBottomNavItem(Icons.receipt_long_rounded, 'Invoices', 2, isDark),
              _buildBottomNavItem(Icons.star_rounded, 'Reviews', 3, isDark),
              _buildBottomNavItem(Icons.person_rounded, 'Profile', 4, isDark),
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
          color: isActive ? DashboardColors.deepPurple.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? DashboardColors.deepPurple : inactiveColor, size: 26),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? DashboardColors.deepPurple : inactiveColor,
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: DashboardColors.drawerGradient,
        ),
        child: SafeArea(
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
                        color: DashboardColors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.user.name,
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
                      widget.user.email,
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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      _buildDrawerItem(Icons.home, 'Home', () {
                        Navigator.pop(context);
                        setState(() => _selectedIndex = 0);
                      }, null),
                      _buildDrawerItem(Icons.shopping_bag_rounded, 'My Orders', () {
                        Navigator.pop(context);
                        setState(() => _selectedIndex = 1);
                      }, null),
                      _buildDrawerItem(Icons.receipt_long_rounded, 'Invoices', () {
                        Navigator.pop(context);
                        setState(() => _selectedIndex = 2);
                      }, null),
                      _buildDrawerItem(Icons.star_rounded, 'Reviews', () {
                        Navigator.pop(context);
                        setState(() => _selectedIndex = 3);
                      }, null),
                      _buildDrawerItem(Icons.shopping_cart, 'Cart', () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartScreen(user: widget.user),
                          ),
                        ).then((_) => setState(() {}));
                      }, cartItemsCount > 0 ? cartItemsCount.toString() : null),
                      _buildDrawerItem(Icons.person, 'Profile', () {
                        Navigator.pop(context);
                        setState(() => _selectedIndex = 4);
                      }, null),
                    ],
                  ),
                ),
              ),
              const Divider(color: Colors.white24, height: 1),
              _buildDrawerItem(Icons.logout, 'Logout', () {
                Navigator.pop(context);
                widget.onLogout();
              }, null),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
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

  Widget _buildHomeTab() {
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
            Text('Our Services', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor)),
            const SizedBox(height: 12),

            // Grid Layout for Categories - FIXED OVERFLOW
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.88, // Changed from 0.95 to 0.88 to give more height
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
                          user: widget.user,
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
                                        color: DashboardColors.deepPurple.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Icon(
                                        IconHelper.getCategoryIcon(category.name).icon,
                                        color: DashboardColors.deepPurple,
                                        size: 14,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: DashboardColors.deepPurple,
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

  Widget _buildBookingsTab() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final shadowOpacity = isDark ? 0.3 : 0.08;

    final bookings = DummyDataService.getUserBookings(widget.user.id);
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
                Expanded(child: _buildOrderTab('Active', 0, activeBookings.length)),
                Expanded(child: _buildOrderTab('Previous', 1, previousBookings.length)),
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
                                color: DashboardColors.deepPurple.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.receipt_long_outlined, size: 64, color: DashboardColors.deepPurple.withOpacity(0.5)),
                            ),
                            const SizedBox(height: 20),
                            Text(_orderTabIndex == 0 ? 'No Active Orders' : 'No Previous Orders', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
                            const SizedBox(height: 8),
                            Text(_orderTabIndex == 0 ? 'Book your first service today!' : 'Your completed orders will appear here', style: TextStyle(fontSize: 14, color: subtitleColor)),
                            if (_orderTabIndex == 0) ...[
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () => setState(() => _selectedIndex = 0),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: DashboardColors.deepPurple,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('Book Now', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
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
                        if (firstBooking.status == BookingStatus.cancelled) return 'Cancelled';
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
                                              decoration: const BoxDecoration(color: DashboardColors.deepPurple, shape: BoxShape.circle),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text('${booking.service?.name ?? 'Service'} (${booking.quantity}x)', style: TextStyle(fontSize: 12, color: textColor)),
                                            ),
                                            Text('SAR ${booking.totalPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: DashboardColors.deepPurple)),
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
                                        Text('Total Amount', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textColor)),
                                        Text('SAR ${totalPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: DashboardColors.deepPurple)),
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
                                            user: widget.user,
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
                                            user: widget.user,
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
                                      color: DashboardColors.deepPurple.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          firstBooking.status == BookingStatus.pending
                                              ? Icons.location_on
                                              : Icons.person_search,
                                          color: DashboardColors.deepPurple,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          firstBooking.status == BookingStatus.pending
                                              ? 'Track Order'
                                              : 'View Technician Details',
                                          style: const TextStyle(
                                            color: DashboardColors.deepPurple,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.arrow_forward,
                                          color: DashboardColors.deepPurple,
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

  Widget _buildOrderTab(String title, int index, int count) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isActive = _orderTabIndex == index;
    final inactiveColor = isDark ? Colors.grey.shade500 : Colors.grey.shade600;

    return InkWell(
      onTap: () => setState(() => _orderTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: isActive ? DashboardColors.deepPurple : Colors.transparent, width: 3)),
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
                color: isActive ? DashboardColors.deepPurple : inactiveColor,
              ),
            ),
            if (count > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive ? DashboardColors.deepPurple : (isDark ? Colors.grey.shade700 : Colors.grey.shade400),
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