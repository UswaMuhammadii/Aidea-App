import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../models/service_model.dart';
import '../../models/cart_model.dart';
import '../../services/dummy_data_service.dart';
import 'service_checkout_screen.dart';
import 'service_detail_screen.dart';
import '../cart/cart_screen.dart';
import '../../utils/icons_helper.dart';

// AppColors
class AppColors {
  static const deepPurple = Color(0xFF7C3AED);
  static const electricBlue = Color(0xFF3B82F6);
  static const brightTeal = Color(0xFF14B8A6);

  static const primaryGradient = LinearGradient(
    colors: [deepPurple, electricBlue, brightTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const accentGradient = LinearGradient(
    colors: [electricBlue, brightTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class ServiceListingScreen extends StatefulWidget {
  final String categoryName;
  final User user;

  const ServiceListingScreen({
    super.key,
    required this.categoryName,
    required this.user,
  });

  @override
  State<ServiceListingScreen> createState() => _ServiceListingScreenState();
}

class _ServiceListingScreenState extends State<ServiceListingScreen> with TickerProviderStateMixin {
  late List<String> _subcategories;
  String? _selectedSubcategory;
  List<String>? _subSubcategories;
  String? _selectedSubSubcategory;
  late List<Service> _services;
  late List<Service> _filteredServices;
  int _selectedQuantity = 1;
  String? _selectedServiceId;
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _subcategories = DummyDataService.getSubcategories(widget.categoryName);
    _services = [];
    _filteredServices = [];

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Icon _getIconForSubcategory(String subcategory) {
    return IconHelper.getServiceIcon(
      subcategory: subcategory,
      color: Colors.white,
      size: 32,
    );
  }

  Icon _getIconForServiceItem(Service service) {
    return IconHelper.getServiceIcon(
      category: service.category,
      subcategory: service.subcategory,
      subSubcategory: service.subSubcategory,
      serviceName: service.name,
      color: Colors.white,
      size: 28,
    );
  }

  void _selectSubcategory(String subcategory) {
    setState(() {
      _selectedSubcategory = subcategory;

      if (subcategory == 'Washing Machine') {
        _subSubcategories = DummyDataService.getWashingMachineTypes();
        _services = [];
        _filteredServices = [];
      } else {
        _subSubcategories = null;
        _selectedSubSubcategory = null;
        _services = DummyDataService.getServicesBySubcategory(
          widget.categoryName,
          subcategory,
        );
        _filteredServices = List.from(_services);
      }

      _selectedServiceId = null;
      _selectedQuantity = 1;
    });
  }

  void _selectSubSubcategory(String type) {
    setState(() {
      _selectedSubSubcategory = type;
      _services = DummyDataService.getWashingMachineServices(type);
      _filteredServices = List.from(_services);
      _selectedServiceId = null;
      _selectedQuantity = 1;
    });
  }

  void _filterServices(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredServices = List.from(_services);
      } else {
        _filteredServices = _services.where((service) {
          return service.name.toLowerCase().contains(query.toLowerCase()) ||
              service.description.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _addToCart(Service service) {
    final existingIndex = globalCart.indexWhere((item) => item.service.id == service.id);

    if (existingIndex != -1) {
      globalCart[existingIndex].quantity += _selectedQuantity;
    } else {
      globalCart.add(CartItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        service: service,
        quantity: _selectedQuantity,
        addedAt: DateTime.now(),
      ));
    }

    setState(() {
      _selectedServiceId = null;
      _selectedQuantity = 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${service.name} to cart!'),
        backgroundColor: AppColors.electricBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartScreen(user: widget.user)),
            );
          },
        ),
      ),
    );
  }

  void _goBack() {
    setState(() {
      if (_selectedSubSubcategory != null) {
        _selectedSubSubcategory = null;
        _services = [];
        _filteredServices = [];
        _searchController.clear();
      } else if (_selectedSubcategory != null) {
        _selectedSubcategory = null;
        _subSubcategories = null;
        _services = [];
        _filteredServices = [];
        _searchController.clear();
      } else {
        Navigator.pop(context);
      }
    });
  }

  int get _cartItemCount => globalCart.fold(0, (sum, item) => sum + item.quantity);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: _selectedSubSubcategory == null && _selectedSubcategory == null,
      onPopInvoked: (didPop) {
        if (!didPop) {
          _goBack();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            _selectedSubSubcategory ?? _selectedSubcategory ?? widget.categoryName,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.surface,
          iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _goBack,
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CartScreen(user: widget.user)),
                    ).then((_) => setState(() {}));
                  },
                ),
                if (_cartItemCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        gradient: AppColors.accentGradient,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '$_cartItemCount',
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
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [
                const Color(0xFF0F172A),
                const Color(0xFF1E293B),
              ]
                  : [
                AppColors.deepPurple.withOpacity(0.03),
                Colors.white,
              ],
            ),
          ),
          child: _selectedSubcategory == null
              ? _buildSubcategoryView()
              : (_subSubcategories != null && _selectedSubSubcategory == null)
              ? _buildSubSubcategoryView()
              : _buildServicesView(),
        ),
      ),
    );
  }

  Widget _buildSubcategoryView() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _subcategories.length,
          itemBuilder: (context, index) {
            final subcategory = _subcategories[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
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
                  onTap: () => _selectSubcategory(subcategory),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: _getIconForSubcategory(subcategory),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subcategory,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                subcategory == 'Washing Machine'
                                    ? 'Choose machine type'
                                    : 'View all services',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSubSubcategoryView() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _subSubcategories!.length,
          itemBuilder: (context, index) {
            final type = _subSubcategories![index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
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
                  onTap: () => _selectSubSubcategory(type),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.local_laundry_service, color: Colors.white, size: 32),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$type Washing Machine',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'View services for $type machines',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildServicesView() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _filterServices,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: 'Search services...',
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.search, color: Colors.white, size: 20),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  onPressed: () {
                    _searchController.clear();
                    _filterServices('');
                  },
                )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: _filteredServices.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No services found',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try adjusting your search terms',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          )
              : FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filteredServices.length,
                itemBuilder: (context, index) {
                  final service = _filteredServices[index];
                  final isSelected = _selectedServiceId == service.id;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected
                              ? AppColors.deepPurple.withOpacity(0.3)
                              : Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                          blurRadius: isSelected ? 20 : 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      border: isSelected
                          ? Border.all(
                        color: AppColors.deepPurple,
                        width: 2,
                      )
                          : null,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            _selectedServiceId = isSelected ? null : service.id;
                            _selectedQuantity = 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: _getIconForServiceItem(service),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      service.name,
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      service.description,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        gradient: AppColors.accentGradient,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'SAR ${service.price.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              if (isSelected)
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: AppColors.primaryGradient,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove, color: Colors.white, size: 18),
                                        padding: const EdgeInsets.all(8),
                                        constraints: const BoxConstraints(),
                                        onPressed: () {
                                          if (_selectedQuantity > 1) {
                                            setState(() {
                                              _selectedQuantity--;
                                            });
                                          }
                                        },
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Text(
                                          _selectedQuantity.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add, color: Colors.white, size: 18),
                                        padding: const EdgeInsets.all(8),
                                        constraints: const BoxConstraints(),
                                        onPressed: () {
                                          setState(() {
                                            _selectedQuantity++;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: AppColors.primaryGradient,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: IconButton(
                                        onPressed: () => _addToCart(service),
                                        icon: const Icon(
                                          Icons.add_shopping_cart,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        constraints: const BoxConstraints(),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ServiceDetailScreen(
                                                service: service,
                                                user: widget.user,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.visibility,
                                          color: Theme.of(context).colorScheme.onSurface,
                                          size: 20,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        constraints: const BoxConstraints(),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        if (_selectedServiceId != null)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.deepPurple.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    final selectedService = _services.firstWhere(
                          (s) => s.id == _selectedServiceId,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceCheckoutScreen(
                          service: selectedService,
                          user: widget.user,
                          quantity: _selectedQuantity,
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          _selectedQuantity.toString(),
                          style: const TextStyle(
                            color: AppColors.deepPurple,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Continue to Checkout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}