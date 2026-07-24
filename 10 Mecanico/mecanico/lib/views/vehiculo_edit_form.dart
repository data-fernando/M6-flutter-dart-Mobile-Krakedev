import 'package:flutter/material.dart';
import '../entity/vehiculo.dart';
import '../services/vehiculo_service.dart';

class VehiculoEditForm extends StatefulWidget {
  final Vehiculo vehiculo;
  const VehiculoEditForm({super.key, required this.vehiculo});

  @override
  State<VehiculoEditForm> createState() => _VehiculoEditFormState();
}

class _VehiculoEditFormState extends State<VehiculoEditForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController placaController;
  late TextEditingController modeloController;
  late TextEditingController marcaController;

  @override
  void initState() {
    super.initState();
    placaController = TextEditingController(text: widget.vehiculo.placa);
    modeloController = TextEditingController(text: widget.vehiculo.modelo);
    marcaController = TextEditingController(text: widget.vehiculo.marca);
  }

  @override
  void dispose() {
    placaController.dispose();
    modeloController.dispose();
    marcaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Vehiculo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: placaController,
                decoration: const InputDecoration(
                  labelText: 'Placa',
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: marcaController,
                decoration: const InputDecoration(
                  labelText: 'Marca',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la marca';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: modeloController,
                decoration: const InputDecoration(
                  labelText: 'Modelo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el modelo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final vehiculo = Vehiculo(
                        placa: placaController.text,
                        marca: marcaController.text,
                        modelo: modeloController.text,
                      );
                      await VehiculoService().actualizarVehiculo(vehiculo);
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
