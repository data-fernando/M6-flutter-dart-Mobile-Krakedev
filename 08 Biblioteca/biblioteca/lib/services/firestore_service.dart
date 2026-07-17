import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class FirestoreService {
  final CollectionReference librosRef =
      FirebaseFirestore.instance.collection('libros');

  Future<void> insertBook(Book book) async {
    await librosRef.add(book.toMap());
  }

  Future<void> updateBook(Book book) async {
    await librosRef.doc(book.id).update(book.toMap());
  }

  Future<void> deleteBook(String id) async {
    await librosRef.doc(id).delete();
  }

  Stream<List<Book>> getAllBooks() {
    return librosRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Book.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
