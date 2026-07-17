import 'package:biblioteca/models/book.dart';
import 'package:biblioteca/services/firestore_service.dart';
import 'package:flutter/material.dart';

class EditBookPage extends StatefulWidget {
  final Book book;
  const EditBookPage({super.key, required this.book});

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}


class _EditBookPageState extends State<EditBookPage> {

  late TextEditingController titleController;
  late TextEditingController authorController;
  late TextEditingController statusController;
  late TextEditingController noteController;
  late String status;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.book.title);
    authorController = TextEditingController(text: widget.book.author);
    statusController = TextEditingController(text: widget.book.status);
    noteController = TextEditingController(text: widget.book.note);
    status = widget.book.status;
  }

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
      appBar: AppBar(title: const Text('Editar Libro'),),
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
              initialValue: status,
              items: [
                DropdownMenuItem(value: 'Pendiente', child: Text('Pendiente')),
                DropdownMenuItem(value: 'Leído', child: Text('Leído')),
                DropdownMenuItem(value: 'En proceso', child: Text('En proceso')),
              ],
              onChanged: (value) {
                setState(() {
                  status = value!;
                  statusController.text = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await FirestoreService().updateBook(Book(
                  id: widget.book.id,
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
