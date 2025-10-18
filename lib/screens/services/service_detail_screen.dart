import 'package:flutter/material.dart';
import '../../models/service_model.dart';
import '../../models/user_model.dart';
import '../../models/cart_model.dart';
import '../cart/cart_screen.dart';
import '../../utils/icons_helper.dart';

class ServiceDetailScreen extends StatefulWidget {
  final Service service;
  final User user;

  const ServiceDetailScreen({Key? key, required this.service, required this.user}) : super(key: key);

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> with TickerProviderStateMixin {
  bool isAddingToCart = false;
  late AnimationController _animationController;
  late AnimationController _buttonAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    _buttonAnimationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.elasticOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  void addToCart() async {
    _buttonAnimationController.forward().then((_) => _buttonAnimationController.reverse());

    setState(() => isAddingToCart = true);

    final existingIndex = globalCart.indexWhere((item) => item.service.id == widget.service.id);

    if (existingIndex != -1) {
      globalCart[existingIndex].quantity += 1;
    } else {
      globalCart.add(CartItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        service: widget.service,
        quantity: 1,
        addedAt: DateTime.now(),
      ));
    }

    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => isAddingToCart = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 8),
              Text('Added ${widget.service.name} to cart successfully!'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          action: SnackBarAction(
            label: 'View Cart',
            textColor: Colors.white,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen(user: widget.user))),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final shadowOpacity = isDark ? 0.3 : 0.08;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          // Header with image
          Container(
            height: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [const Color(0xFF1E293B).withOpacity(0.5), const Color(0xFF0F172A)]
                    : [Theme.of(context).colorScheme.primary.withOpacity(0.1), Theme.of(context).colorScheme.secondary.withOpacity(0.05)],
              ),
            ),
            child: Stack(
              children: [
                // Back button
                Positioned(
                  top: 50,
                  left: 16,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 5))],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: textColor, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                // Service image with animation
                Center(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: isDark ? [const Color(0xFF334155), const Color(0xFF1E293B)] : [Colors.white, Colors.grey.shade50],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.4 : 0.15), blurRadius: 30, offset: const Offset(0, 10))],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconHelper.getServiceIcon(
                              category: widget.service.category,
                              subcategory: widget.service.subcategory,
                              subSubcategory: widget.service.subSubcategory,
                              serviceName: widget.service.name,
                              color: Theme.of(context).colorScheme.primary,
                              size: 80,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.service.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: textColor
                              ),
                              textAlign: TextAlign.center,
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

          // Content with animations
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service title and price
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(shadowOpacity), blurRadius: 15, offset: const Offset(0, 5))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                widget.service.name,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textColor
                                )
                            ),
                            const SizedBox(height: 8),
                            Text(
                                widget.service.description,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: subtitleColor
                                )
                            ),
                            const SizedBox(height: 16),
                            // Price section
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF6B5B9A), Color(0xFF7C3AED)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                  'SAR ${widget.service.price.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Includes section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(shadowOpacity), blurRadius: 15, offset: const Offset(0, 5))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.check_circle, color: Colors.green, size: 24),
                                const SizedBox(width: 8),
                                Text(
                                    "What's Included",
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: textColor
                                    )
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ...widget.service.features.map((feature) => _buildIncludeItem('✓', feature, Colors.green, textColor, subtitleColor)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Does not include section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(shadowOpacity), blurRadius: 15, offset: const Offset(0, 5))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.cancel, color: Colors.red, size: 24),
                                const SizedBox(width: 8),
                                Text(
                                    'Not Included',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: textColor
                                    )
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildIncludeItem('✗', 'Any type of repair', Colors.red, textColor, subtitleColor),
                            _buildIncludeItem('✗', 'Any type of material', Colors.red, textColor, subtitleColor),
                            _buildIncludeItem('✗', 'Ladder', Colors.red, textColor, subtitleColor),
                          ],
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // Bottom action bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.4 : 0.1), blurRadius: 20, offset: const Offset(0, -10))],
        ),
        child: SafeArea(
          child: ScaleTransition(
            scale: _buttonAnimationController,
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B5B9A), Color(0xFF7C3AED)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(
                    color: const Color(0xFF6B5B9A).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8)
                )],
              ),
              child: ElevatedButton(
                onPressed: isAddingToCart ? null : addToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: isAddingToCart
                    ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3
                    )
                )
                    : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart, size: 22, color: Colors.white),
                    SizedBox(width: 16),
                    Text(
                        'Add to Cart',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIncludeItem(String icon, String text, Color color, Color textColor, Color subtitleColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.3), width: 1),
            ),
            child: Center(
              child: Text(
                  icon,
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  )
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
                text,
                style: TextStyle(
                    color: subtitleColor,
                    fontWeight: FontWeight.w500
                )
            ),
          ),
        ],
      ),
    );
  }
}