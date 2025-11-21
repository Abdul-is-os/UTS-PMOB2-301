import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_cubit.dart';
import '../blocs/cart_state.dart';

class CartSummaryPage extends StatelessWidget {
  const CartSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan BlocBuilder untuk merebuild UI saat CartState berubah
    return Scaffold(
      appBar: AppBar(title: const Text('Ringkasan Keranjang')),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cartCubit = context.read<CartCubit>();
          final items = state.items;

          if (items.isEmpty) {
            return const Center(child: Text('Keranjang Anda kosong.'));
          }

          return Column(
            children: [
              // 1. Daftar Produk di Keranjang
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      leading: Image.asset(
                        item.product.image,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.product.name),
                      subtitle: Text('Rp ${item.product.price} x ${item.qty}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Hapus produk dari keranjang
                          cartCubit.removeFromCart(item.product);
                        },
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              // 2. Total Item dan Total Harga
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Item:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${cartCubit.getTotalItems()}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'TOTAL HARGA:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Rp ${cartCubit.getTotalPrice().toString()}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // 3. Tombol Checkout
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Panggil fungsi clearCart() untuk mengosongkan keranjang
                          cartCubit.clearCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Checkout Berhasil! Keranjang dikosongkan.',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
