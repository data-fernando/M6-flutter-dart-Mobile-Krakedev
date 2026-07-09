import 'package:flutter/material.dart';
import 'package:navegacionflutter/pages/customersPage.dart';
import 'package:navegacionflutter/pages/homepage2.dart';
import 'package:navegacionflutter/pages/listView.dart';
import 'package:navegacionflutter/pages/productspage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomePage()
      home: HomePage2(),
      routes: {
        '/customers': (context) => CustomersPage(),
        '/products': (context) => ProductsPage(),
        '/homepage2': (context) => const HomePage2(),
        '/listView': (context) => const ListViewPage(),

      }
    );
  }
}
