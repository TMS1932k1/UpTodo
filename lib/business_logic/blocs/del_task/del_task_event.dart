import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DelTaskEvent extends Equatable {
  final String id;
  final User user;

  const DelTaskEvent({required this.user, required this.id});
}

class DelEvent extends DelTaskEvent {
  const DelEvent({required super.user, required super.id});

  @override
  List<Object?> get props => [];
}
