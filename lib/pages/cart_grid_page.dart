import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

class CartGridPage extends StatelessWidget {
  CartGridPage({super.key});

  // Contoh data dummy (simulasi pengambilan data produk)
  final List<ProductModel> dummyProducts = [
    ProductModel(
      id: 'P001',
      name: 'Nasi Goreng Spesial',
      price: 25000,
      image: 'assets/nasigoreng.jpg',
    ),
    ProductModel(
      id: 'P002',
      name: 'Mie Ayam Jumbo',
      price: 20000,
      image: 'assets/mieayam.jpg',
    ),
    ProductModel(
      id: 'P003',
      name: 'Es Teh Manis',
      price: 5000,
      image: 'assets/teh.jpg',
    ),
    ProductModel(
      id: 'P004',
      name: 'Air Mineral',
      price: 3000,
      image: 'assets/mizu.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, // Lebar maksimal kartu ideal
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: dummyProducts.length,
      itemBuilder: (context, index) {
        final product = dummyProducts[index];
        // Menggunakan ProductCard yang sudah dibuat sebelumnya
        return ProductCard(product: product);
      },
    );
  }
}
