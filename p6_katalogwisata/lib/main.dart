import 'package:flutter/material.dart';
import 'package:p6_katalogwisata/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Wisata',
      home: HomePage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 255, 117, 163),
          foregroundColor: Colors.white,
        )
      ),
    );
  }
}