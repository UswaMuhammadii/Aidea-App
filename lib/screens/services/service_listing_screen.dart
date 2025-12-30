import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../models/service_model.dart';
import '../../models/cart_model.dart';

import '../../services/firestore_service.dart';
import 'service_checkout_screen.dart';

import '../cart/cart_screen.dart';
import '../../utils/icons_helper.dart';
import '../../gen_l10n/app_localizations.dart';
import '../../utils/formatting_utils.dart';
import '../../utils/app_colors.dart';

class ServiceListingScreen extends StatefulWidget {
  final ServiceCategory category;
  final User user;

  const ServiceListingScreen({
    super.key,
    required this.category,
    required this.user,
  });

  @override
  State<ServiceListingScreen> createState() => _ServiceListingScreenState();
}

class _ServiceListingScreenState extends State<ServiceListingScreen>
    with TickerProviderStateMixin {
  List<String> _subcategories = [];
  String? _selectedSubcategory;
  // List<String>? _subSubcategories; // Removed
  String? _selectedSubSubcategory;
  List<Service> _services = [];
  List<Service> _filteredServices = [];
  int _selectedQuantity = 1;
  String? _selectedServiceId;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  // bool _isDataLoaded = false; // Removed as part of dynamic loading refactor

  @override
  void initState() {
    super.initState();

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

    // Fetch all services immediately to populate subcategories
    _fetchServices();
  }

  // Not used anymore as we fetch services dynamically
  // void _loadSubcategories() ...

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // No need to call loadSubcategories here anymore
  }

  Widget _getIconForSubcategory(String subcategory) {
    return IconHelper.getServiceIcon(
      subcategory: subcategory,
      color: Colors.white,
      size: 32,
    );
  }

  Widget _getIconForServiceItem(Service service) {
    // If we have an image URL, try to show it
    if (service.imageUrl != null && service.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          service.imageUrl!,
          fit: BoxFit.cover,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: child,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            // Fallback to icon on error
            return Center(
              child: IconHelper.getServiceIcon(
                category: service.category,
                subcategory: service.subcategory,
                subSubcategory: service.subSubcategory,
                serviceName: service.name,
                color: Colors.white,
                size: 28,
              ),
            );
          },
        ),
      );
    }

    // Default icon behavior
    return Center(
      child: IconHelper.getServiceIcon(
        category: service.category,
        subcategory: service.subcategory,
        subSubcategory: service.subSubcategory,
        serviceName: service.name,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  void _selectSubcategory(String subcategory) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    setState(() {
      _selectedSubcategory = subcategory;
      // _subSubcategories = null;
      _selectedSubSubcategory = null;
      _filterServicesBySubcategory(subcategory);

      _selectedServiceId = null;
      _selectedQuantity = 1;
    });
  }

  Future<void> _fetchServices() async {
    // Fetch ALL services for this category
    final firestoreService = FirestoreService();
    final services =
        await firestoreService.getServicesByCategory(widget.category.id);

    if (!mounted) return;

    final l10n = AppLocalizations.of(context);
    final isArabic = l10n?.localeName == 'ar';

    // Dynamically extract unique subcategories
    final Set<String> uniqueSubcategories = {};
    for (var service in services) {
      final sub = isArabic
          ? (service.subcategoryArabic ?? service.subcategory)
          : service.subcategory;
      if (sub != null && sub.isNotEmpty) {
        uniqueSubcategories.add(sub);
      }
    }

    setState(() {
      _services = services;
      // If no services found, maybe fallback to category subcategories (if any)
      if (uniqueSubcategories.isEmpty) {
        if (isArabic) {
          _subcategories = widget.category.subcategoriesArabic.isNotEmpty
              ? widget.category.subcategoriesArabic
              : (widget.category.subcategories ?? []);
        } else {
          _subcategories = widget.category.subcategories ?? [];
        }
      } else {
        _subcategories = uniqueSubcategories.toList();
      }
      // _isDataLoaded = true;
    });
  }

  // Filter the ALREADY FETCHED list
  void _filterServicesBySubcategory(String subcategory) {
    final l10n = AppLocalizations.of(context);
    final isArabic = l10n?.localeName == 'ar';

    setState(() {
      _filteredServices = _services.where((s) {
        final sub =
            isArabic ? (s.subcategoryArabic ?? s.subcategory) : s.subcategory;
        return sub == subcategory;
      }).toList();
    });
  }

/*
  void _selectSubSubcategory(String type) {
    // Removed
  }
*/

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

  void _addToCart(Service service, AppLocalizations l10n) {
    final existingIndex =
        globalCart.indexWhere((item) => item.service.id == service.id);

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
        content: Text(l10n.addedToCartSuccessfully(service.name)),
        backgroundColor: AppColors.electricBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: l10n.viewCart,
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
        // _subSubcategories = null;
        // _services = []; // Fix: Don't clear master list of services
        _filteredServices = [];
        _searchController.clear();
      } else {
        Navigator.pop(context);
      }
    });
  }

  int get _cartItemCount =>
      globalCart.fold(0, (sum, item) => sum + item.quantity);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    if (l10n == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return PopScope(
      canPop: _selectedSubSubcategory == null && _selectedSubcategory == null,
      onPopInvoked: (didPop) {
        if (!didPop) {
          _goBack();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text(
            _selectedSubSubcategory ??
                _selectedSubcategory ??
                (Localizations.localeOf(context).languageCode == 'ar' &&
                        widget.category.nameArabic.isNotEmpty
                    ? widget.category.nameArabic
                    : widget.category.name),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.surface,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onSurface),
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
                      MaterialPageRoute(
                          builder: (_) => CartScreen(user: widget.user)),
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
                        FormattingUtils.formatNumber(_cartItemCount, locale),
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
          decoration: const BoxDecoration(
            color: Colors.white, // Fixed: Removed incorrect color array syntax
          ),
          child: _selectedSubcategory == null
              ? _buildSubcategoryView(l10n)
              : _buildServicesView(l10n, locale),
        ),
      ),
    );
  }

  Widget _buildSubcategoryView(AppLocalizations l10n) {
    if (_subcategories.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

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
                    color: Colors.black.withOpacity(0.05),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                subcategory == l10n.washingMachine
                                    ? l10n.chooseMachineType
                                    : l10n.viewAllServices,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
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

/*
  Widget _buildSubSubcategoryView(AppLocalizations l10n) {
     // Removed dummy sub-subcategory view
     return Container();
  }
*/

  Widget _buildServicesView(AppLocalizations l10n, Locale locale) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterServices,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: l10n.searchServices,
                  hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  prefixIcon: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        const Icon(Icons.search, color: Colors.white, size: 20),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
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
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.noServicesFound,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.tryAdjustingYourSearchTerms,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
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
                        controller: _scrollController,
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
                                      : Colors.black.withOpacity(0.05),
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
                                    _selectedServiceId =
                                        isSelected ? null : service.id;
                                    _selectedQuantity = 1;
                                  });

                                  if (!isSelected &&
                                      _scrollController.hasClients) {
                                    Future.delayed(
                                        const Duration(milliseconds: 100), () {
                                      _scrollController.animateTo(
                                        _scrollController.position.pixels + 100,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOut,
                                      );
                                    });
                                  }
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: _getIconForServiceItem(service),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Localizations.localeOf(context)
                                                              .languageCode ==
                                                          'ar' &&
                                                      service
                                                          .nameArabic.isNotEmpty
                                                  ? service.nameArabic
                                                  : service.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                  ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              service.description,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                gradient:
                                                    AppColors.accentGradient,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                FormattingUtils.formatCurrency(
                                                    service.price,
                                                    l10n,
                                                    locale),
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.remove,
                                                    color: Colors.white,
                                                    size: 18),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                constraints:
                                                    const BoxConstraints(),
                                                onPressed: () {
                                                  if (_selectedQuantity > 1) {
                                                    setState(() {
                                                      _selectedQuantity--;
                                                    });
                                                  }
                                                },
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Text(
                                                  FormattingUtils.formatNumber(
                                                      _selectedQuantity,
                                                      locale),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.add,
                                                    color: Colors.white,
                                                    size: 18),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                constraints:
                                                    const BoxConstraints(),
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
                                                gradient:
                                                    AppColors.primaryGradient,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: IconButton(
                                                onPressed: () =>
                                                    _addToCart(service, l10n),
                                                icon: const Icon(
                                                  Icons.add_shopping_cart,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                constraints:
                                                    const BoxConstraints(),
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
                  color:
                      AppColors.electricBlue, // ✅ ELECTRIC BLUE (no gradient)
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.electricBlue
                          .withOpacity(0.4), // ✅ Electric blue shadow
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
                            FormattingUtils.formatNumber(
                                _selectedQuantity, locale),
                            style: const TextStyle(
                              color: AppColors.deepPurple,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          l10n.continueToCheckout,
                          style: const TextStyle(
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
      ), // Close Column
    ); // Close SafeArea
  }
}
