import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/user_model.dart';
import '../../models/service_model.dart';
import '../../models/booking_model.dart';
import '../../models/cart_model.dart';
import '../../services/dummy_data_service.dart';
import '../services/service_listing_screen.dart';
import '../profile/profile_screen.dart';
import '../cart/cart_screen.dart';
import '../../widget/service_image_widget.dart';

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
  int _orderTabIndex = 0; // 0 = Active, 1 = Previous

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
    _categories = DummyDataService.getCategories();
  }

  void _changeAddress() {
    _showLocationPicker();
  }

  void _showLocationPicker() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
                      color: const Color(0xFF6B5B9A).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Color(0xFF6B5B9A),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _selectedAddress,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.my_location, color: Color(0xFF6B5B9A)),
                title: const Text('Use my current location'),
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Getting current location...'),
                      backgroundColor: Color(0xFF6B5B9A),
                    ),
                  );
                },
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_city, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Lahore',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            _selectedAddress,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
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
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  int get cartItemsCount {
    return globalCart.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8F9FA),
      drawer: _buildDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // Beautiful Header - Only show on home screen
            if (_selectedIndex == 0)
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF6B5B9A),
                      Color(0xFF7C3AED),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B5B9A).withOpacity(0.3),
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
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CartScreen(user: widget.user),
                                    ),
                                  ).then((_) => setState(() {}));
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 24),
                                    ),
                                    if (cartItemsCount > 0)
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          constraints: const BoxConstraints(
                                            minWidth: 18,
                                            minHeight: 18,
                                          ),
                                          child: Text(
                                            cartItemsCount.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 24),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Aidea Technology',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
              ),

            // Content
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  _buildHomeTab(),
                  _buildBookingsTab(),
                  ProfileScreen(user: widget.user, onLogout: widget.onLogout),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavItem(Icons.home_rounded, 'Home', 0),
                _buildBottomNavItem(Icons.receipt_long_rounded, 'Orders', 1),
                _buildBottomNavItem(Icons.person_rounded, 'Profile', 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6B5B9A),
              Color(0xFFD7CCC8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),
              // User Profile Section
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xFF6B5B9A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.user.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.user.email,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Menu Items
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Column(
                    children: [
                      _buildDrawerItem(
                        icon: Icons.home,
                        title: 'Home',
                        onTap: () {
                          Navigator.pop(context);
                          setState(() => _selectedIndex = 0);
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.receipt_long,
                        title: 'My Orders',
                        onTap: () {
                          Navigator.pop(context);
                          setState(() => _selectedIndex = 1);
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.shopping_cart,
                        title: 'Cart',
                        badge: cartItemsCount > 0 ? cartItemsCount.toString() : null,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartScreen(user: widget.user),
                            ),
                          ).then((_) => setState(() {}));
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.person,
                        title: 'Profile',
                        onTap: () {
                          Navigator.pop(context);
                          setState(() => _selectedIndex = 2);
                        },
                      ),
                      const Spacer(),
                      _buildDrawerItem(
                        icon: Icons.logout,
                        title: 'Logout',
                        onTap: () {
                          Navigator.pop(context);
                          widget.onLogout();
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? badge,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (badge != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    final isActive = _selectedIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF6B5B9A).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF6B5B9A) : Colors.grey.shade600,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? const Color(0xFF6B5B9A) : Colors.grey.shade600,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Our Services',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ..._categories.map((category) => _buildCategoryCard(category)),
          ],
        ),
      ),
    );
  }

  // dashboard_screen.dart mein _buildCategoryCard method ko replace karen

  // dashboard_screen.dart mein _buildCategoryCard method

  Widget _buildCategoryCard(ServiceCategory category) {
    // Service listing screen jaisa hi icon function use karen
    Icon getCategoryIcon(String categoryName) {
      switch (categoryName) {
        case 'AC Services':
          return const Icon(Icons.ac_unit, color: Colors.lightBlue, size: 28);
        case 'Washing Machine Service':
          return const Icon(Icons.local_laundry_service, color: Colors.blue, size: 28);
        case 'Refrigerator Service':
          return const Icon(Icons.kitchen, color: Colors.teal, size: 28);
        case 'Other Services':
          return const Icon(Icons.microwave, color: Colors.deepOrange, size: 28);
        default:
          return const Icon(Icons.build, color: Colors.grey, size: 28);
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
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
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,  // ⬅️ Light background
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: getCategoryIcon(category.name),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${category.services.length} services available',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6B5B9A).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF6B5B9A),
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),

              // Category Image (sirf yahan)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: ServiceImageWidget(
                  imageUrl: DummyDataService.getCategoryImage(category.name),
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // dashboard_screen.dart ke _buildBookingsTab() method ko replace karen

  Widget _buildBookingsTab() {
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

    // Group bookings by date and time (bookings made together)
    Map<String, List<Booking>> groupBookings(List<Booking> bookingList) {
      Map<String, List<Booking>> grouped = {};
      for (var booking in bookingList) {
        String key = '${booking.bookingDate}_${booking.bookingTime}';
        if (!grouped.containsKey(key)) {
          grouped[key] = [];
        }
        grouped[key]!.add(booking);
      }
      return grouped;
    }

    final displayBookings = _orderTabIndex == 0 ? activeBookings : previousBookings;
    final groupedBookings = groupBookings(displayBookings);

    return Container(
      color: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          // Tabs for Active and Previous
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: _buildOrderTab('Active', 0, activeBookings.length),
                ),
                Expanded(
                  child: _buildOrderTab('Previous', 1, previousBookings.length),
                ),
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6B5B9A).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.receipt_long_outlined,
                                size: 64,
                                color: const Color(0xFF6B5B9A).withOpacity(0.5),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              _orderTabIndex == 0 ? 'No Active Orders' : 'No Previous Orders',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _orderTabIndex == 0
                                  ? 'Book your first service today!'
                                  : 'Your completed orders will appear here',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            if (_orderTabIndex == 0) ...[
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() => _selectedIndex = 0);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD7CCC8),
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Book Now',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
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
                      final totalPrice = bookingGroup.fold<double>(
                          0.0,
                              (sum, booking) => sum + booking.totalPrice
                      );

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
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
                                          firstBooking.statusColor.withOpacity(0.1),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      firstBooking.status == BookingStatus.completed
                                          ? Icons.check_circle
                                          : firstBooking.status == BookingStatus.cancelled
                                          ? Icons.cancel
                                          : Icons.access_time,
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
                                              ? '${bookingGroup.length} Services Booked'
                                              : firstBooking.service?.name ?? 'Service',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: firstBooking.statusColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            firstBooking.statusText,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: firstBooking.statusColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              // Show all services in the group
                              if (bookingGroup.length > 1) ...[
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Services:',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      ...bookingGroup.map((booking) => Padding(
                                        padding: const EdgeInsets.only(bottom: 4),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 4,
                                              height: 4,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF6B5B9A),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                '${booking.service?.name ?? 'Service'} (${booking.quantity}x)',
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            Text(
                                              'SAR ${booking.totalPrice.toStringAsFixed(0)}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF6B5B9A),
                                              ),
                                            ),
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
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Date & Time',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        Text(
                                          '${DateFormat('MMM d, y').format(firstBooking.bookingDate)} at ${DateFormat('h:mm a').format(firstBooking.bookingTime)}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total Amount',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'SAR ${totalPrice.toStringAsFixed(0)}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF6B5B9A),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
    final isActive = _orderTabIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _orderTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? const Color(0xFF6B5B9A) : Colors.transparent,
              width: 3,
            ),
          ),
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
                color: isActive ? const Color(0xFF6B5B9A) : Colors.grey
                    .shade600,
              ),
            ),
            if (count > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFF6B5B9A) : Colors.grey
                      .shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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