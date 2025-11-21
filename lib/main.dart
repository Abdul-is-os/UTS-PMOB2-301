import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Pastikan import ini sesuai dengan nama folder Anda
import 'blocs/cart_cubit.dart';
import 'pages/cart_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider 'menyuntikkan' Cubit ke seluruh aplikasi
    return BlocProvider(
      create: (context) => CartCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Menghilangkan banner debug
        title: 'UTS Kasir Flutter',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const CartHomePage(), // Mengarah ke halaman utama
      ),
    );
  }
}
