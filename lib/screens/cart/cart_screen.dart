import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../models/cart_model.dart';
import '../services/service_checkout_screen.dart';
import '../../utils/icons_helper.dart';
import '../../utils/app_colors.dart';
import '../../gen_l10n/app_localizations.dart';
import '../../utils/formatting_utils.dart'; // Add this import

class CartScreen extends StatefulWidget {
  final User user;

  const CartScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get totalPrice {
    return globalCart.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  void updateQuantity(String itemId, int newQuantity) {
    if (newQuantity <= 0) {
      globalCart.removeWhere((item) => item.id == itemId);
    } else {
      final item = globalCart.firstWhere((item) => item.id == itemId);
      item.quantity = newQuantity;
    }
    setState(() {});
  }

  void removeItem(String itemId) {
    globalCart.removeWhere((item) => item.id == itemId);
    setState(() {});
  }

  void proceedToCheckout() {
    if (globalCart.isEmpty) return;

    // For now, take the first service from the cart (you can handle multiple later)
    final firstItem = globalCart.first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceCheckoutScreen(
          service: firstItem.service, // ✅ REQUIRED parameter
          user: widget.user,
          quantity: firstItem.quantity,
          isFromCart: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context); // Add locale

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    if (globalCart.isEmpty) {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text(l10n.cart),
          backgroundColor: cardColor,
          foregroundColor: textColor,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.electricBlue.withValues(alpha: 0.1),
                      AppColors.electricBlue.withValues(alpha: 0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 80,
                  color: AppColors.electricBlue,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.yourCartIsEmpty,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.addSomeServicesToGetStarted,
                style: TextStyle(
                  fontSize: 16,
                  color: subtitleColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(globalCart.isEmpty
            ? l10n.cart
            : l10n.cartWithCount.replaceAll('\$COUNT\$', globalCart.length.toString())),
        backgroundColor: cardColor,
        foregroundColor: textColor,
        elevation: 0,
        actions: [
          if (globalCart.isNotEmpty)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                    title: Text('Clear Cart', style: TextStyle(color: textColor)),
                    content: Text(
                      l10n.areYouSureYouWantToRemoveAllItems,
                      style: TextStyle(color: subtitleColor),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(l10n.cancel, style: TextStyle(color: subtitleColor)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.red, Colors.redAccent],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            globalCart.clear();
                            Navigator.pop(context);
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(l10n.clear),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Text(l10n.clearAll,
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: globalCart.length,
              itemBuilder: (context, index) {
                final item = globalCart[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.electricBlue.withValues(alpha: 0.15),
                                AppColors.electricBlue.withValues(alpha: 0.15),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconHelper.getServiceIcon(
                            category: item.service.category,
                            subcategory: item.service.subcategory,
                            subSubcategory: item.service.subSubcategory,
                            serviceName: item.service.name,
                            color: AppColors.electricBlue,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.service.name,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.service.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: subtitleColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                FormattingUtils.formatCurrency(item.service.price, l10n, locale),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.electricBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [AppColors.electricBlue, AppColors.electricBlue],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => updateQuantity(item.id, item.quantity - 1),
                                    icon: const Icon(Icons.remove, color: Colors.white, size: 16),
                                    padding: const EdgeInsets.all(6),
                                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                  ),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        FormattingUtils.formatNumber(item.quantity, locale), // ← UPDATED
                                        style: const TextStyle(
                                          color: AppColors.electricBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => updateQuantity(item.id, item.quantity + 1),
                                    icon: const Icon(Icons.add, color: Colors.white, size: 16),
                                    padding: const EdgeInsets.all(6),
                                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              FormattingUtils.formatCurrency(item.totalPrice, l10n, locale),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.electricBlue,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => removeItem(item.id),
                          icon: const Icon(Icons.delete_outline, color: Colors.red, size: 22),
                          padding: const EdgeInsets.all(6),
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${l10n.total}:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        FormattingUtils.formatCurrency(totalPrice, l10n, locale),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.electricBlue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: proceedToCheckout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.electricBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      child: Text(l10n.proceedToCheckout,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}