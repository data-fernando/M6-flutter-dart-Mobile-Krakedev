import 'package:flutter/material.dart';
import 'package:navegacionflutter/pages/productspage.dart' show ProductsPage;

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('HomePage')),
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ProductsPage()),
            );
          },
          child: Text('Moverse a otra pagina'),
        ),
      ),
    );
  }
}
