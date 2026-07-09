import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

void imprimir() {
  print("hola estoy imprimiendo");
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: imprimir,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        drawer: const Drawer(
          child: Column(
            children: [
              SizedBox(height: 60),
              Text("Opcion 1"),
              Text("Opcion 2"),
              Text("Opcion 3"),
            ],
          ),
        ),
        body: const Center(child: Text('widget!')),
        appBar: AppBar(
          title: const Center(child: Text("Hola mundo")),
          backgroundColor: Colors.amberAccent,
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ), //se quita el constante al app bar
        backgroundColor: Colors.blue,
      ),
    );
  }
}
