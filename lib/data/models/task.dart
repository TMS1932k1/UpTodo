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
}
