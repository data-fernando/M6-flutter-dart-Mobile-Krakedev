import 'package:basedatos_sqlite/product_form.dart';
import 'package:basedatos_sqlite/product_list.dart';
import 'package:flutter/material.dart';
import 'package:basedatos_sqlite/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductsListView(),
      routes: {
        Routes.add: (context) => ProductForm(),
      },
    );
  }
}
