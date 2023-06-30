import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class EditTaskEvent extends Equatable {
  const EditTaskEvent();
}

class DelEvent extends EditTaskEvent {
  final String id;
  final User user;

  const DelEvent({required this.user, required this.id});

  @override
  List<Object?> get props => [];
}

class CompleteEvent extends EditTaskEvent {
  final String id;
  final User user;

  const CompleteEvent({required this.user, required this.id});

  @override
  List<Object?> get props => [];
}

class EditEvent extends EditTaskEvent {
  final String id;
  final User user;
  final Map<String, dynamic> changes;

  const EditEvent({
    required this.user,
    required this.id,
    required this.changes,
  });

  @override
  List<Object?> get props => [];
}
