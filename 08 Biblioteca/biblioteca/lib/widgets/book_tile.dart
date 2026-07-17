import 'package:flutter/material.dart';
import 'package:biblioteca/models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const BookTile({
    super.key,
    required this.book,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(book.title),
        subtitle: Text(book.author),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}