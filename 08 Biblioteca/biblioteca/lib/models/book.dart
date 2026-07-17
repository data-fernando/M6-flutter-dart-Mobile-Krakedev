class Book {
  final String? id;
  final String title;
  final String author;
  final String status;
  final String note;

  Book({this.id, required this.title, required this.author, required this.status, required this.note});

  Map<String, dynamic> toMap() => {
    'titulo': title,
    'autor': author,
    'estado': status,
    'nota': note,
  };

  factory Book.fromMap(String id, Map<String, dynamic> map) => Book(
    id: id,
    title: map['titulo'] ?? '',
    author: map['autor'] ?? '',
    status: map['estado'] ?? '',
    note: map['nota'] ?? '',
  );
}
