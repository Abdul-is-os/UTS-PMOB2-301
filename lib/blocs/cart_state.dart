// lib/blocs/cart_state.dart
import '../models/cart_item.dart';

class CartState {
  final List<CartItem> items;

  CartState({required this.items});

  // Contoh state awal (opsional)
  factory CartState.initial() => CartState(items: []);
}
