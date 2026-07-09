import 'package:flutter/material.dart';
import 'package:navegacionflutter/pages/customersPage.dart';
import 'package:navegacionflutter/routes.dart';


class HomePage2 extends StatelessWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('named Navegation Reto 15')),
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 100,),

          MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.customers);
            },
            color: Colors.green,
            textColor: Colors.white,
            child: const Text('Ir a Clientes'),
          ),
          MaterialButton(
            onPressed: () {

              Navigator.pushNamed(context, Routes.listView); // ir a un componente nombrado en la ruta
            },
            color: Colors.blueAccent,
            textColor: Colors.white,
            child: const Text('Ir a lista fija'),
          ),     MaterialButton(
            onPressed: () {

              Navigator.pushNamed(context, Routes.products); // ir a un componente lista dinamica
            },
            color: Colors.red,
            textColor: Colors.white,
            child: const Text('Ir a lista Productos'),
          ),
        ],
      ),
    );
  }
}
