class Task {
  final String id;
  String title;
  String? description;
  int? flag;
  DateTime? dateTime;
  int? category;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.flag,
    required this.dateTime,
    required this.category,
    required this.isCompleted,
  });
}
