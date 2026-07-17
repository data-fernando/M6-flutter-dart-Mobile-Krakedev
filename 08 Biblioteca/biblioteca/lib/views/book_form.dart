import 'package:biblioteca/models/book.dart';
import 'package:biblioteca/services/firestore_service.dart';
import 'package:flutter/material.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}


class _AddBookPageState extends State<AddBookPage> {

  final titleController=TextEditingController();
  final authorController=TextEditingController();
  final statusController=TextEditingController(text: 'Pendiente');
  final noteController=TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    statusController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Libro'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(
                labelText: 'Autor',
              ),
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(
                labelText: 'Nota',
              ),
            ),
            DropdownButtonFormField(
              initialValue: 'Pendiente',
              items: [
                DropdownMenuItem(value: 'Pendiente', child: Text('Pendiente')),
                DropdownMenuItem(value: 'Leído', child: Text('Leído')),
                DropdownMenuItem(value: 'En proceso', child: Text('En proceso')),
              ],
              onChanged: (value) {
                setState(() {
                  statusController.text = value.toString();
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await FirestoreService().insertBook(Book(
                  title: titleController.text,
                  author: authorController.text,
                  status: statusController.text,
                  note: noteController.text,
                ));
                if (!context.mounted) return;
                Navigator.pop(context, true);
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
