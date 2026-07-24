import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../entity/orden.dart';
import '../entity/mecanico.dart';
import '../entity/vehiculo.dart';
import '../services/orden_service.dart';
import '../services/mecanico_service.dart';
import '../services/vehiculo_service.dart';

class OrdenEditForm extends StatefulWidget {
  final Orden orden;
  const OrdenEditForm({super.key, required this.orden});

  @override
  State<OrdenEditForm> createState() => _OrdenEditFormState();
}

class _OrdenEditFormState extends State<OrdenEditForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController descripcionController;

  List<Mecanico> _mecanicos = [];
  List<Vehiculo> _vehiculos = [];
  late String _vehiculoSeleccionado;
  late String _mecanicoSeleccionado;
  late String _estadoSeleccionado;
  late DateTime _fechaIngreso;
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
    _vehiculoSeleccionado = widget.orden.fkVehiculo;
    _mecanicoSeleccionado = widget.orden.fkMecanico;
    _estadoSeleccionado = widget.orden.estado;
    _fechaIngreso = widget.orden.fechaIngreso;
    _fechaEntrega = widget.orden.fechaEntrega;
    descripcionController =
        TextEditingController(text: widget.orden.descripcion);
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final mecanicos = await MecanicoService().obtenerTodosLosMecanicos();
    final vehiculos = await VehiculoService().obtenerTodosLosVehiculos();
    setState(() {
      _mecanicos = mecanicos;
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
    final mecanico = _mecanicos.firstWhere(
      (m) => m.cedula == _mecanicoSeleccionado,
      orElse: () => Mecanico(
          cedula: '', nombre: '', especialidad: 'Mecanico General'),
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
    final df = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Orden')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Orden #${widget.orden.id}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _vehiculoSeleccionado,
                  decoration: const InputDecoration(
                    labelText: 'Vehiculo',
                    border: OutlineInputBorder(),
                  ),
                  items: _vehiculos
                      .map((v) => DropdownMenuItem(
                            value: v.placa,
                            child:
                                Text('${v.marca} ${v.modelo} (${v.placa})'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _vehiculoSeleccionado = value!;
                    });
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _mecanicoSeleccionado,
                  decoration: const InputDecoration(
                    labelText: 'Mecanico',
                    border: OutlineInputBorder(),
                  ),
                  items: _mecanicos
                      .map((m) => DropdownMenuItem(
                            value: m.cedula,
                            child: Text(
                                '${m.nombre} - ${m.especialidad}${m.disponibilidad ? '' : ' (No disponible)'}'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _mecanicoSeleccionado = value!;
                    });
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
                  subtitle: Text(df.format(_fechaIngreso)),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => _seleccionarFecha(context, true),
                ),
                ListTile(
                  title: const Text('Fecha de Entrega'),
                  subtitle: Text(
                      _fechaEntrega != null ? df.format(_fechaEntrega!) : 'No definida'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => _seleccionarFecha(context, false),
                ),
                const SizedBox(height: 12),
                Card(
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Precio calculado: \$${precioCalculado.toStringAsFixed(2)}',
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final orden = Orden(
                          id: widget.orden.id,
                          fkVehiculo: _vehiculoSeleccionado,
                          fkMecanico: _mecanicoSeleccionado,
                          estado: _estadoSeleccionado,
                          descripcion: descripcionController.text,
                          fechaIngreso: _fechaIngreso,
                          fechaEntrega: _fechaEntrega,
                          precio: precioCalculado,
                        );
                        await OrdenService().actualizarOrden(orden);
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Actualizar Orden'),
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
