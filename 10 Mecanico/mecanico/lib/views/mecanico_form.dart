import 'package:flutter/material.dart';
import '../entity/mecanico.dart';
import '../services/mecanico_service.dart';

class MecanicoForm extends StatefulWidget {
  const MecanicoForm({super.key});

  @override
  State<MecanicoForm> createState() => _MecanicoFormState();
}

class _MecanicoFormState extends State<MecanicoForm> {
  final _formKey = GlobalKey<FormState>();
  final cedulaController = TextEditingController();
  final nombreController = TextEditingController();
  String especialidadSeleccionada = 'Mecanico General';
  bool disponibilidad = true;

  final List<String> especialidades = [
    'Mecanico General',
    'Electricista',
    'Latonero',
    'Pintor',
    'Soldador',
    'Diesel',
  ];

  @override
  void dispose() {
    cedulaController.dispose();
    nombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Mecanico')),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la cedula';
                  }
                  return null;
                },
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
                      await MecanicoService().insertarMecanico(mecanico);
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
