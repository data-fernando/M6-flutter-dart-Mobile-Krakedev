import 'package:flutter/material.dart';
import '../entity/orden.dart';
import '../entity/mecanico.dart';
import '../entity/vehiculo.dart';
import '../services/orden_service.dart';
import '../services/mecanico_service.dart';
import '../services/vehiculo_service.dart';

class OrdenForm extends StatefulWidget {
  const OrdenForm({super.key});

  @override
  State<OrdenForm> createState() => _OrdenFormState();
}

class _OrdenFormState extends State<OrdenForm> {
  final _formKey = GlobalKey<FormState>();
  final descripcionController = TextEditingController();

  List<Mecanico> _mecanicosDisponibles = [];
  List<Vehiculo> _vehiculos = [];
  String? _vehiculoSeleccionado;
  String? _mecanicoSeleccionado;
  String _estadoSeleccionado = 'Pendiente';
  DateTime _fechaIngreso = DateTime.now();
  DateTime? _fechaEntrega;

  final List<String> _estados = [
    'Pendiente',
    'En Proceso',
    'Completada',
    'Cancelada',
  ];

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final mecanicos =
        await MecanicoService().obtenerMecanicosDisponibles();
    final vehiculos = await VehiculoService().obtenerTodosLosVehiculos();
    setState(() {
      _mecanicosDisponibles = mecanicos;
      _vehiculos = vehiculos;
    });
  }

  @override
  void dispose() {
    descripcionController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha(BuildContext context, bool esIngreso) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: esIngreso ? _fechaIngreso : (_fechaEntrega ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      final TimeOfDay? hora = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      final DateTime fechaCompleta = DateTime(
        picked.year,
        picked.month,
        picked.day,
        hora?.hour ?? DateTime.now().hour,
        hora?.minute ?? DateTime.now().minute,
      );
      setState(() {
        if (esIngreso) {
          _fechaIngreso = fechaCompleta;
        } else {
          _fechaEntrega = fechaCompleta;
        }
      });
    }
  }

  double _calcularPrecio() {
    if (_mecanicoSeleccionado == null) return 0.0;
    final mecanico = _mecanicosDisponibles.firstWhere(
      (m) => m.cedula == _mecanicoSeleccionado,
    );
    return Orden.calcularPrecio(
      especialidad: mecanico.especialidad,
      fechaIngreso: _fechaIngreso,
      fechaEntrega: _fechaEntrega,
    );
  }

  @override
  Widget build(BuildContext context) {
    final precioCalculado = _calcularPrecio();

    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Orden')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_vehiculos.isEmpty)
                  const Card(
                    color: Colors.amber,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'No hay vehiculos registrados. Cree uno primero.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                else
                  DropdownButtonFormField<String>(
                    value: _vehiculoSeleccionado,
                    decoration: const InputDecoration(
                      labelText: 'Vehiculo',
                      border: OutlineInputBorder(),
                    ),
                    items: _vehiculos
                        .map((v) => DropdownMenuItem(
                              value: v.placa,
                              child: Text('${v.marca} ${v.modelo} (${v.placa})'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _vehiculoSeleccionado = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) return 'Seleccione un vehiculo';
                      return null;
                    },
                  ),
                const SizedBox(height: 12),
                if (_mecanicosDisponibles.isEmpty)
                  const Card(
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'No hay mecanicos disponibles. Active la disponibilidad de uno.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  )
                else
                  DropdownButtonFormField<String>(
                    value: _mecanicoSeleccionado,
                    decoration: const InputDecoration(
                      labelText: 'Mecanico (solo disponibles)',
                      border: OutlineInputBorder(),
                    ),
                    items: _mecanicosDisponibles
                        .map((m) => DropdownMenuItem(
                              value: m.cedula,
                              child: Text(
                                  '${m.nombre} - ${m.especialidad}'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _mecanicoSeleccionado = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) return 'Seleccione un mecanico';
                      return null;
                    },
                  ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _estadoSeleccionado,
                  decoration: const InputDecoration(
                    labelText: 'Estado',
                    border: OutlineInputBorder(),
                  ),
                  items: _estados
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _estadoSeleccionado = value!;
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: descripcionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripcion del problema',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese una descripcion';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                ListTile(
                  title: const Text('Fecha de Ingreso'),
                  subtitle: Text(_fechaIngreso.toString()),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => _seleccionarFecha(context, true),
                ),
                ListTile(
                  title: const Text('Fecha de Entrega (opcional)'),
                  subtitle: Text(
                      _fechaEntrega?.toString() ?? 'No definida'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => _seleccionarFecha(context, false),
                ),
                const SizedBox(height: 12),
                Card(
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Precio estimado: \$${precioCalculado.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (_vehiculos.isEmpty || _mecanicosDisponibles.isEmpty)
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              final orden = Orden(
                                fkVehiculo: _vehiculoSeleccionado!,
                                fkMecanico: _mecanicoSeleccionado!,
                                estado: _estadoSeleccionado,
                                descripcion: descripcionController.text,
                                fechaIngreso: _fechaIngreso,
                                fechaEntrega: _fechaEntrega,
                                precio: precioCalculado,
                              );
                              await OrdenService().insertarOrden(orden);

                              await MecanicoService().actualizarDisponibilidad(
                                  _mecanicoSeleccionado!, false);

                              if (!context.mounted) return;
                              Navigator.pop(context);
                            }
                          },
                    child: const Text('Crear Orden'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
