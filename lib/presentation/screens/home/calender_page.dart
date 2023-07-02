import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_bloc.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_state.dart';
import 'package:todo_app/business_logic/cubits/calender/filter_cubit.dart';
import 'package:todo_app/business_logic/cubits/calender/filter_state.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/presentation/screens/task/task_screen.dart';
import 'package:todo_app/presentation/widgets/home/calendar/calendar_bar.dart';
import 'package:todo_app/presentation/widgets/home/calendar/filter_bar.dart';
import 'package:todo_app/presentation/widgets/home/calendar/show_filter_task.dart';
import 'package:todo_app/presentation/widgets/home/task_list_item.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = [];
    DateTime date = DateTime.now();
    bool isCompleted = false;

    /// Add state to cubit to filter task
    void filterTask(DateTime date, bool isCompleted, List<Task> tasks) {
      BlocProvider.of<FilterCubit>(context)
          .filterTasks(date, isCompleted, tasks);
    }

    // Get all tasks
    final state = BlocProvider.of<LoadTaskBloc>(context).state;
    if (state is LoadedState) {
      tasks = state.tasks!;
    }
    filterTask(date, isCompleted, tasks);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Calendar',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        leading: Scaffold.of(context).hasDrawer
            ? IconButton(
                iconSize: 24,
                icon: FaIcon(
                  FontAwesomeIcons.bars,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                onPressed: () {
                  // Open Drawer
                  Scaffold.of(context).openDrawer();
                },
              )
            : null,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            CalendarBar(setDate: (setDate) {
              date = setDate;
              filterTask(date, isCompleted, tasks);
            }),
            const SizedBox(height: kPaddingMedium),
            FilterBar(setIsCompleted: (setCompleted) {
              isCompleted = setCompleted;
              filterTask(date, isCompleted, tasks);
            }),
            const SizedBox(height: kPaddingSmall),
            const ShowFilterTask(),
          ],
        ),
      ),
    );
  }
}
