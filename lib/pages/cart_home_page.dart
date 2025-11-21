import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_cubit.dart';
import '../blocs/cart_state.dart';
import 'cart_grid_page.dart';
import 'cart_summary_page.dart';

class CartHomePage extends StatelessWidget {
  const CartHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Kita gunakan BlocBuilder di sini untuk menampilkan Badge jumlah item
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();
        final totalItems = cartCubit.getTotalItems();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Aplikasi Kasir Mobile'),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      // Navigasi ke Halaman Ringkasan Keranjang
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartSummaryPage(),
                        ),
                      );
                    },
                  ),
                  // Menampilkan Badge Jumlah Item
                  if (totalItems > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          totalItems.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          // Konten utama adalah Grid Produk
          body: CartGridPage(),
        );
      },
    );
  }
}
