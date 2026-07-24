import 'package:flutter/material.dart';
import '../entity/mecanico.dart';
import '../services/mecanico_service.dart';

class MecanicoEditForm extends StatefulWidget {
  final Mecanico mecanico;
  const MecanicoEditForm({super.key, required this.mecanico});

  @override
  State<MecanicoEditForm> createState() => _MecanicoEditFormState();
}

class _MecanicoEditFormState extends State<MecanicoEditForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController cedulaController;
  late TextEditingController nombreController;
  late String especialidadSeleccionada;
  late bool disponibilidad;

  final List<String> especialidades = [
    'Mecanico General',
    'Electricista',
    'Latonero',
    'Pintor',
    'Soldador',
    'Diesel',
  ];

  @override
  void initState() {
    super.initState();
    cedulaController = TextEditingController(text: widget.mecanico.cedula);
    nombreController = TextEditingController(text: widget.mecanico.nombre);
    especialidadSeleccionada = widget.mecanico.especialidad;
    disponibilidad = widget.mecanico.disponibilidad;
  }

  @override
  void dispose() {
    cedulaController.dispose();
    nombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Mecanico')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: cedulaController,
                decoration: const InputDecoration(
                  labelText: 'Cedula',
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: especialidadSeleccionada,
                decoration: const InputDecoration(
                  labelText: 'Especialidad',
                  border: OutlineInputBorder(),
                ),
                items: especialidades
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    especialidadSeleccionada = value!;
                  });
                },
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text('Disponible'),
                value: disponibilidad,
                onChanged: (value) {
                  setState(() {
                    disponibilidad = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final mecanico = Mecanico(
                        cedula: cedulaController.text,
                        nombre: nombreController.text,
                        especialidad: especialidadSeleccionada,
                        disponibilidad: disponibilidad,
                      );
                      await MecanicoService().actualizarMecanico(mecanico);
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Actualizar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
