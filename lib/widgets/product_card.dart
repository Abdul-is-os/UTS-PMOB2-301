import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../blocs/cart_cubit.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    // Akses CartCubit
    final cartCubit = context.read<CartCubit>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk
            Image.asset(
              product.image, // Asumsi image adalah path aset lokal
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            // Nama Produk
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Harga Produk
            Text(
              'Rp ${product.price.toString()}',
              style: const TextStyle(color: Colors.green, fontSize: 14),
            ),
            const SizedBox(height: 8),
            // Tombol Tambah ke Keranjang
            ElevatedButton(
              onPressed: () {
                // Panggil fungsi addToCart dari CartCubit
                cartCubit.addToCart(product);
                // Tampilkan notifikasi
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} ditambahkan ke keranjang!'),
                  ),
                );
              },
              child: const Text('Tambah ke Keranjang'),
            ),
          ],
        ),
      ),
    );
  }
}
