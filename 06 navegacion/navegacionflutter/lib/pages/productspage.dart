import 'package:flutter/material.dart';
import 'package:navegacionflutter/entities/Product.dart';

class ProductsPage extends StatelessWidget {

    ProductsPage({Key? key}) : super(key: key);

    final List<Product> products = [
      Product(name: 'Producto 1', price: 100, description: 'Descripcion 1'),
      Product(name: 'Producto 2', price: 200, description: 'Descripcion 2'),
      Product(name: 'Producto 3', price: 300, description: 'Descripcion 3'),
      Product(name: 'Producto 4', price: 400, description: 'Descripcion 4'),
      Product(name: 'Producto 5', price: 500, description: 'Descripcion 5'),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Products ListViewBuilder')),
        backgroundColor: Colors.amberAccent,
        leading: IconButton( //remmplazar el boton de regreso por defecto
          icon: Icon(Icons.star),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder( itemCount: products.length, itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text(product.description),
          trailing: Text("\$${product.price.toStringAsFixed(2)}"),
        );
      },
      ),
    );
  }
}