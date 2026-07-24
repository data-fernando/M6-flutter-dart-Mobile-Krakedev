import 'package:flutter/material.dart';
import '../entity/mecanico.dart';
import '../services/mecanico_service.dart';
import 'mecanico_form.dart';
import 'mecanico_edit_form.dart';

class MecanicosPage extends StatefulWidget {
  const MecanicosPage({super.key});

  @override
  State<MecanicosPage> createState() => _MecanicosPageState();
}

class _MecanicosPageState extends State<MecanicosPage> {
  final MecanicoService _service = MecanicoService();
  List<Mecanico> _mecanicos = [];

  @override
  void initState() {
    super.initState();
    _cargarMecanicos();
  }

  Future<void> _cargarMecanicos() async {
    final mecanicos = await _service.obtenerTodosLosMecanicos();
    setState(() {
      _mecanicos = mecanicos;
    });
  }

  Future<void> _confirmarEliminar(Mecanico mecanico) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Mecanico'),
        content: Text('Desea eliminar a ${mecanico.nombre}?'),
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
      await _service.eliminarMecanico(mecanico.cedula!);
      _cargarMecanicos();
    }
  }

  Future<void> _toggleDisponibilidad(Mecanico mecanico) async {
    await _service.actualizarDisponibilidad(
        mecanico.cedula!, !mecanico.disponibilidad);
    _cargarMecanicos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mecanicos.isEmpty
          ? const Center(child: Text('No hay mecanicos registrados'))
          : ListView.builder(
              itemCount: _mecanicos.length,
              itemBuilder: (context, index) {
                final mecanico = _mecanicos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          mecanico.disponibilidad ? Colors.green : Colors.red,
                      child: Text(mecanico.nombre[0].toUpperCase()),
                    ),
                    title: Text(mecanico.nombre),
                    subtitle: Text(
                        'C.I: ${mecanico.cedula} | ${mecanico.especialidad}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: mecanico.disponibilidad,
                          onChanged: (_) => _toggleDisponibilidad(mecanico),
                          activeColor: Colors.green,
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MecanicoEditForm(mecanico: mecanico),
                              ),
                            );
                            _cargarMecanicos();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmarEliminar(mecanico),
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
            MaterialPageRoute(builder: (context) => const MecanicoForm()),
          );
          _cargarMecanicos();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
