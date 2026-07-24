import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../entity/orden.dart';
import '../entity/mecanico.dart';
import '../entity/vehiculo.dart';
import '../services/orden_service.dart';
import '../services/mecanico_service.dart';
import '../services/vehiculo_service.dart';
import 'orden_form.dart';
import 'orden_edit_form.dart';

class OrdenesPage extends StatefulWidget {
  const OrdenesPage({super.key});

  @override
  State<OrdenesPage> createState() => _OrdenesPageState();
}

class _OrdenesPageState extends State<OrdenesPage> {
  final OrdenService _ordenService = OrdenService();
  final MecanicoService _mecanicoService = MecanicoService();
  final VehiculoService _vehiculoService = VehiculoService();
  List<Orden> _ordenes = [];
  Map<String, String> _nombresMecanicos = {};
  Map<String, String> _placasVehiculos = {};

  @override
  void initState() {
    super.initState();
    _cargarOrdenes();
  }

  Future<void> _cargarOrdenes() async {
    final ordenes = await _ordenService.obtenerTodasLasOrdenes();
    final mecanicos = await _mecanicoService.obtenerTodosLosMecanicos();
    final vehiculos = await _vehiculoService.obtenerTodosLosVehiculos();

    setState(() {
      _ordenes = ordenes;
      _nombresMecanicos = {
        for (var m in mecanicos) m.cedula!: m.nombre,
      };
      _placasVehiculos = {
        for (var v in vehiculos) v.placa!: '${v.marca} ${v.modelo}',
      };
    });
  }

  Future<void> _confirmarEliminar(Orden orden) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Orden'),
        content: const Text('Desea eliminar esta orden?'),
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
      await _ordenService.eliminarOrden(orden.id!);
      _cargarOrdenes();
    }
  }

  Color _colorEstado(String estado) {
    switch (estado) {
      case 'Pendiente':
        return Colors.orange;
      case 'En Proceso':
        return Colors.blue;
      case 'Completada':
        return Colors.green;
      case 'Cancelada':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ordenes.isEmpty
          ? const Center(child: Text('No hay ordenes registradas'))
          : ListView.builder(
              itemCount: _ordenes.length,
              itemBuilder: (context, index) {
                final orden = _ordenes[index];
                final nombreMecanico =
                    _nombresMecanicos[orden.fkMecanico] ??orden.fkMecanico;
                final placaVehiculo =
                    _placasVehiculos[orden.fkVehiculo] ?? orden.fkVehiculo;
                final df = DateFormat('dd/MM/yyyy HH:mm');

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _colorEstado(orden.estado),
                      child: Text('#${orden.id}'),
                    ),
                    title: Text(orden.descripcion),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Vehiculo: $placaVehiculo'),
                        Text('Mecanico: $nombreMecanico'),
                        Text(
                            'Ingreso: ${df.format(orden.fechaIngreso)}'),
                        if (orden.fechaEntrega != null)
                          Text('Entrega: ${df.format(orden.fechaEntrega!)}'),
                        Text(
                          'Precio: \$${orden.precio.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _colorEstado(orden.estado),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            orden.estado,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 11),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OrdenEditForm(orden: orden),
                              ),
                            );
                            _cargarOrdenes();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmarEliminar(orden),
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
            MaterialPageRoute(builder: (context) => const OrdenForm()),
          );
          _cargarOrdenes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
