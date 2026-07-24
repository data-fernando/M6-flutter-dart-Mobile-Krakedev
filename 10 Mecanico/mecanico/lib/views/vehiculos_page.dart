import 'package:flutter/material.dart';
import '../entity/vehiculo.dart';
import '../services/vehiculo_service.dart';
import 'vehiculo_form.dart';
import 'vehiculo_edit_form.dart';

class VehiculosPage extends StatefulWidget {
  const VehiculosPage({super.key});

  @override
  State<VehiculosPage> createState() => _VehiculosPageState();
}

class _VehiculosPageState extends State<VehiculosPage> {
  final VehiculoService _service = VehiculoService();
  List<Vehiculo> _vehiculos = [];

  @override
  void initState() {
    super.initState();
    _cargarVehiculos();
  }

  Future<void> _cargarVehiculos() async {
    final vehiculos = await _service.obtenerTodosLosVehiculos();
    setState(() {
      _vehiculos = vehiculos;
    });
  }

  Future<void> _confirmarEliminar(Vehiculo vehiculo) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Vehiculo'),
        content: Text('Desea eliminar el vehiculo ${vehiculo.placa}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _service.eliminarVehiculo(vehiculo.placa!);
      _cargarVehiculos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _vehiculos.isEmpty
          ? const Center(child: Text('No hay vehiculos registrados'))
          : ListView.builder(
              itemCount: _vehiculos.length,
              itemBuilder: (context, index) {
                final vehiculo = _vehiculos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.directions_car),
                    ),
                    title: Text('${vehiculo.marca} ${vehiculo.modelo}'),
                    subtitle: Text('Placa: ${vehiculo.placa}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VehiculoEditForm(vehiculo: vehiculo),
                              ),
                            );
                            _cargarVehiculos();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmarEliminar(vehiculo),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VehiculoForm()),
          );
          _cargarVehiculos();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
