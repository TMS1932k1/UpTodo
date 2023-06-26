import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/cubits/sort/sort_state.dart';
import 'package:todo_app/data/models/task.dart';

class SortCubit extends Cubit<SortState> {
  SortCubit() : super(SortState(sorted: []));

  /// Sort with flag
  void sortDefault(List<Task> tasks) {
    tasks.sort(
      (t1, t2) {
        if (t1.flag != null && t2.flag != null) {
          return (t1.flag! > t2.flag! ? 1 : -1);
        }

        if (t1.flag != null) {
          return -1;
        }

        if (t2.flag != null) {
          return 1;
        }

        return 0;
      },
    );
    emit(SortState(sorted: tasks));
  }

  /// Sort with flag
  void sortDate(List<Task> tasks) {
    tasks.sort(
      (t1, t2) {
        if (t1.dateTime != null && t2.dateTime != null) {
          return (t1.dateTime!.compareTo(t2.dateTime!));
        }

        if (t1.dateTime != null) {
          return -1;
        }

        if (t2.dateTime != null) {
          return 1;
        }

        return 0;
      },
    );
    emit(SortState(sorted: tasks));
  }

  /// Sort with flag
  void sortAZ(List<Task> tasks) {
    tasks.sort(
      (t1, t2) =>
          t1.title.characters.first.compareTo(t2.title.characters.first),
    );
    emit(SortState(sorted: tasks));
  }
}
