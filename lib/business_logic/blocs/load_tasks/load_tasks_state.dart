import 'package:equatable/equatable.dart';
import 'package:todo_app/data/models/task.dart';

abstract class LoadTasksState extends Equatable {
  List<Task>? tasks;
  List<Task>? toDo;
  List<Task>? missDo;
  List<Task>? completeDo;

  LoadTasksState({
    this.tasks,
    this.toDo,
    this.completeDo,
    this.missDo,
  });
}

class LoadingState extends LoadTasksState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends LoadTasksState {
  LoadedState({
    List<Task>? tasks,
    List<Task>? toDo,
    List<Task>? completeDo,
    List<Task>? missDo,
  }) : super(
          tasks: tasks,
          toDo: toDo,
          completeDo: completeDo,
          missDo: missDo,
        );

  @override
  List<Object?> get props => [];
}

class ErrorState extends LoadTasksState {
  @override
  List<Object?> get props => [];
}
