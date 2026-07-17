
import 'package:biblioteca/models/book.dart';
import 'package:biblioteca/services/firestore_service.dart';
import 'package:biblioteca/views/book_edit_form.dart';
import 'package:biblioteca/widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca/views/book_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirestoreService _firestoreService = FirestoreService();

  Future _confirmDeleteBook(String id) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar libro?'),
        content: const Text('¿Estas seguro de eliminar este libro?'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biblioteca')),
      

      body: StreamBuilder<List<Book>>(
        stream: _firestoreService.getAllBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay libros registrados'));
          }
          final books = snapshot.data!;
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return BookTile(
                book: book,
                onDelete: () async {
                  final confirm = await _confirmDeleteBook(book.id!);
                  if (confirm != null && confirm) {
                    await _firestoreService.deleteBook(book.id!);
                  }
                },
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditBookPage(book: book),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
         floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddBookPage(),
          ),
        );
      }, child: const Icon(Icons.add)),  
    );
  }
}
