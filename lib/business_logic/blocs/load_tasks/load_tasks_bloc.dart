import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_event.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_state.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/data/repositories/task_firbase.dart';

class LoadTaskBloc extends Bloc<LoadTasksEvent, LoadTasksState> {
  LoadTaskBloc() : super(LoadingState()) {
    on<LoadEvent>((event, emit) async {
      emit(LoadingState());
      final tasks = await loadAllTasks(
        user: FirebaseAuth.instance.currentUser!,
      );
      if (tasks != null) {
        List<Task>? toDo;
        List<Task>? missDo;
        List<Task>? completeDo;

        // Split to toDo
        toDo = tasks.where((task) {
          if (task.isCompleted ||
              (task.dateTime != null &&
                  DateTime.fromMillisecondsSinceEpoch(
                    task.dateTime!.millisecondsSinceEpoch,
                  ).isBefore(DateTime.now()))) {
            return false;
          }
          return true;
        }).toList();

        // Split to completeDo
        completeDo = tasks.where((task) => task.isCompleted).toList();

        // Split to missDo
        missDo = tasks.where((task) {
          if (!task.isCompleted &&
              task.dateTime != null &&
              DateTime.fromMillisecondsSinceEpoch(
                task.dateTime!.millisecondsSinceEpoch,
              ).isBefore(DateTime.now())) {
            return true;
          }
          return false;
        }).toList();

        emit(
          LoadedState(
            tasks: tasks,
            toDo: toDo,
            completeDo: completeDo,
            missDo: missDo,
          ),
        );
      } else {
        emit(ErrorState());
      }
    });
  }
}
