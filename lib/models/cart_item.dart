// lib/models/cart_item.dart
import 'product_model.dart';

class CartItem {
  final ProductModel product;
  int qty;

  CartItem({required this.product, required this.qty});
}
