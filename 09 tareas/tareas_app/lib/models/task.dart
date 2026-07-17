class Task {
  final int? id;
  final String title;
  final String description;
  final String dueDate;
  final String status;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'status': status,
    };
    if (id != null) map['id'] = id;
    return map;
  }
}
