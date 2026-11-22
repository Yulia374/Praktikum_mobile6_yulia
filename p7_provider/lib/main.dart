import 'package:flutter/material.dart';
import 'package:p7_provider/cart_model.dart';
import 'package:p7_provider/product_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elektronika',
      home: ProductPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}