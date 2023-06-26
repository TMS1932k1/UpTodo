import 'package:equatable/equatable.dart';

abstract class LoadTasksEvent extends Equatable {
  const LoadTasksEvent();
}

class LoadEvent extends LoadTasksEvent {
  @override
  List<Object?> get props => [];
}
