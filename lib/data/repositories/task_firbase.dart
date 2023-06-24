import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

/// Add new task with params
/// If have error to return error's message
Future<String?> upNewTask({
  required String title,
  required User user,
  String? description,
  DateTime? datetime,
  int? idCategory,
  int? flag,
}) async {
  Map<String, dynamic> data = {
    'id': const Uuid().v4(),
    'title': title,
    if (description != null) 'description': description,
    if (datetime != null) 'datetime': datetime,
    if (idCategory != null) 'id_category': idCategory,
    if (flag != null) 'flag': flag,
  };
  try {
    await FirebaseFirestore.instance.collection(user.uid).add(data);
  } catch (e) {
    return 'Error in adding task to Firebase';
  }
  return null;
}
