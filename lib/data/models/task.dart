import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  String title;
  String? description;
  int? flag;
  Timestamp? dateTime;
  int? category;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.flag,
    this.dateTime,
    this.category,
    this.isCompleted = false,
  });

  Task.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        flag = map['flag'],
        dateTime = map['datetime'],
        category = map['id_category'],
        isCompleted = map['is_completed'];
}
