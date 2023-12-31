import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:uuid/uuid.dart';

/// Add new task with params
/// If have error will return error's message
Future<String?> upNewTask({
  required String title,
  required User user,
  String? description,
  DateTime? datetime,
  int? idCategory,
  int? flag,
}) async {
  final id = const Uuid().v4();
  Map<String, dynamic> data = {
    'id': id,
    'title': title,
    if (description != null) 'description': description,
    if (datetime != null) 'datetime': datetime,
    if (idCategory != null) 'id_category': idCategory,
    if (flag != null) 'flag': flag,
    'is_completed': false,
  };
  try {
    await FirebaseFirestore.instance
        .collection(user.uid)
        .doc('tasks')
        .collection('tasks')
        .doc(id)
        .set(data);
  } catch (e) {
    return 'Error in adding task to Firebase';
  }
  return null;
}

/// Add all tasks on Firebase
/// If have error will return null
Future<List<Task>?> loadAllTasks({
  required User user,
}) async {
  final List<Task> tasks = [];
  try {
    final data = await FirebaseFirestore.instance
        .collection(user.uid)
        .doc('tasks')
        .collection('tasks')
        .get();

    if (data.size <= 0) return tasks;

    for (var doc in data.docs) {
      tasks.add(Task.fromMap(doc.data()));
    }
    return tasks;
  } catch (e) {
    return null;
  }
}

/// Delete task with task's id
/// If have error will return error's message
Future<String?> delTask({
  required User user,
  required String id,
}) async {
  try {
    await FirebaseFirestore.instance
        .collection(user.uid)
        .doc('tasks')
        .collection('tasks')
        .doc(id)
        .delete();
    return null;
  } catch (e) {
    return 'Error in deleting task';
  }
}

/// Edit complte task with task's id
/// If have error will return error's message
Future<String?> completeTask({
  required User user,
  required String id,
}) async {
  try {
    await FirebaseFirestore.instance
        .collection(user.uid)
        .doc('tasks')
        .collection('tasks')
        .doc(id)
        .update({'is_completed': true});
    return null;
  } catch (e) {
    return 'Error in editting task';
  }
}

/// Edit task's detail with task's id
/// If have error will return error's message
Future<String?> editTask({
  required User user,
  required String id,
  required Map<String, dynamic> changes,
}) async {
  try {
    await FirebaseFirestore.instance
        .collection(user.uid)
        .doc('tasks')
        .collection('tasks')
        .doc(id)
        .update(changes);
    return null;
  } catch (e) {
    return 'Error in editting task';
  }
}
