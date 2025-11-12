import 'service_model.dart';
import '../../gen_l10n/app_localizations.dart';
class CartItem {
  final String id;
  final Service service;
  int quantity;
  final DateTime addedAt;

  CartItem({
    required this.id,
    required this.service,
    required this.quantity,
    required this.addedAt,
  });

  double get totalPrice => service.price * quantity;
}

// Global cart
final List<CartItem> globalCart = [];

