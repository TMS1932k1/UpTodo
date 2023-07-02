import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/cubits/calender/filter_state.dart';
import 'package:todo_app/data/models/task.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit()
      : super(
          FilterState(tasks: []),
        );

  void filterTasks(
    DateTime date,
    bool isCompleted,
    List<Task> tasks,
  ) {
    // Filter with date and isCompleted
    tasks = tasks.where(
      (task) {
        if (task.dateTime == null) {
          return false;
        }

        // Convert timestamp to datetime
        final dateTask = DateTime.fromMillisecondsSinceEpoch(
          task.dateTime!.millisecondsSinceEpoch,
        );
        date = date.copyWith(
          hour: 0,
          minute: 0,
          microsecond: 0,
          millisecond: 0,
          second: 0,
        );

        // Get end day with [date]
        final endDay = date.add(const Duration(days: 1));

        if (dateTask.isBefore(date) ||
            dateTask.isAfter(endDay) ||
            task.isCompleted != isCompleted) {
          return false;
        }

        return true;
      },
    ).toList();

    emit(FilterState(tasks: tasks));
  }
}
