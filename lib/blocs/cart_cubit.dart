import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart'; // Keluar dari blocs/, masuk ke models/
import '../models/cart_item.dart'; // Keluar dari blocs/, masuk ke models/
import 'cart_state.dart'; // Bersebelahan

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial());

  // Helper untuk mencari CartItem berdasarkan Product ID
  CartItem? _findItem(String productId) {
    try {
      return state.items.firstWhere((item) => item.product.id == productId);
    } catch (e) {
      return null;
    }
  }

  // 1. Fungsi addToCart
  void addToCart(ProductModel product) {
    final currentItems = List<CartItem>.from(state.items);
    final existingItem = _findItem(product.id);

    if (existingItem != null) {
      // Jika produk sudah ada, tingkatkan kuantitas
      existingItem.qty += 1;
    } else {
      // Jika produk belum ada, tambahkan item baru
      currentItems.add(CartItem(product: product, qty: 1));
    }

    emit(CartState(items: currentItems)); // Memicu perubahan state
  }

  // 2. Fungsi removeFromCart
  void removeFromCart(ProductModel product) {
    final currentItems = List<CartItem>.from(state.items);
    currentItems.removeWhere((item) => item.product.id == product.id);

    emit(CartState(items: currentItems));
  }

  // 3. Fungsi updateQuantity
  void updateQuantity(ProductModel product, int qty) {
    final currentItems = List<CartItem>.from(state.items);
    final existingItem = _findItem(product.id);

    if (existingItem != null) {
      if (qty > 0) {
        existingItem.qty = qty;
      } else {
        // Jika qty <= 0, hapus item (sesuai logika kasir)
        currentItems.remove(existingItem);
      }

      emit(CartState(items: currentItems));
    }
  }

  // 4. Fungsi getTotalItems
  int getTotalItems() {
    return state.items.fold(0, (sum, item) => sum + item.qty);
  }

  // 5. Fungsi getTotalPrice
  int getTotalPrice() {
    return state.items.fold(
      0,
      (sum, item) => sum + (item.product.price * item.qty),
    );
  }

  // Fungsi tambahan untuk Checkout/Clear Cart
  void clearCart() {
    emit(CartState.initial());
  }
}
