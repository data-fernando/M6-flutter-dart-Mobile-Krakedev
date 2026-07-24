import 'package:flutter/material.dart';
import 'mecanicos_page.dart';
import 'vehiculos_page.dart';
import 'ordenes_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Taller Mecanico'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person), text: 'Mecanicos'),
              Tab(icon: Icon(Icons.directions_car), text: 'Vehiculos'),
              Tab(icon: Icon(Icons.build), text: 'Ordenes'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MecanicosPage(),
            VehiculosPage(),
            OrdenesPage(),
          ],
        ),
      ),
    );
  }
}
