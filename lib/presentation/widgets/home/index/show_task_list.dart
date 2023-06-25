import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:todo_app/constants/app_constant.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/presentation/widgets/home/index/task_grid_item.dart';
import 'package:todo_app/presentation/widgets/home/index/task_list_item.dart';

class ShowTaskList extends StatefulWidget {
  const ShowTaskList({super.key});

  @override
  State<ShowTaskList> createState() => _ShowTaskListState();
}

class _ShowTaskListState extends State<ShowTaskList> {
  List<Task>? toDo;
  List<Task>? missDo;
  List<Task>? completeDo;

  /// Split [tasks] to [toDo], [missDo] and [completeDo]
  ///  + [toDo] : not outdate and [isCompleted] == false
  ///  + [missDo] : outdate and [isCompleted] == false
  ///  + [completeDo] : [isCompleted] == true
  void splitTaskList(List<Task> tasks) {
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

    completeDo = tasks.where((task) => task.isCompleted).toList();

    missDo = tasks.where((task) {
      if (task.isCompleted ||
          (task.dateTime != null &&
              DateTime.fromMillisecondsSinceEpoch(
                task.dateTime!.millisecondsSinceEpoch,
              ).isAfter(DateTime.now()))) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Get height/width of device
    final sizeDevice = MediaQuery.of(context).size;
    final isTablet = sizeDevice.width > 600;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        Widget emptyScreen = Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                emptyListImage,
                width: 227,
                height: 227,
              ),
              const SizedBox(height: kPaddingSmall),
              Text(
                'What do you want to do today?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: kPaddingSmall),
              Text(
                'Tap + to add your tasks',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );

        if (!snapshot.hasData) {
          return emptyScreen;
        }

        // Convert data to array
        final List<Task> tasks = [];
        for (var doc in snapshot.data!.docs) {
          tasks.add(Task.fromMap(doc.data()));
        }

        if (tasks.isEmpty) {
          return emptyScreen;
        } else {
          splitTaskList(tasks);
        }

        return Container(
          padding: const EdgeInsets.all(kPaddingSmall),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (toDo!.isNotEmpty)
                  _buildTaskList(
                    context: context,
                    isTablet: isTablet,
                    tasks: toDo!,
                    title: 'To Do',
                  ),
                if (completeDo!.isNotEmpty)
                  const SizedBox(height: kPaddingMedium),
                if (completeDo!.isNotEmpty)
                  _buildTaskList(
                    context: context,
                    isTablet: isTablet,
                    tasks: completeDo!,
                    title: 'Completed Tasks',
                    isShowCheck: true,
                  ),
                if (missDo!.isNotEmpty) const SizedBox(height: kPaddingMedium),
                if (missDo!.isNotEmpty)
                  _buildTaskList(
                    context: context,
                    isTablet: isTablet,
                    tasks: missDo!,
                    title: 'Miss Tasks',
                    isShowCheck: true,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildTitle(BuildContext context, String title) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall,
      ),
      const SizedBox(width: kPaddingSmall),
      const Expanded(child: Divider(thickness: 2)),
    ],
  );
}

Widget _buildTaskList({
  required BuildContext context,
  required List<Task> tasks,
  required bool isTablet,
  required String title,
  bool isShowCheck = false,
}) {
  return Column(
    children: [
      _buildTitle(context, title),
      const SizedBox(height: kPaddingSmall),
      isTablet
          ? MasonryGrid(
              crossAxisSpacing: kPaddingSmall,
              column: 3,
              children: tasks
                  .map(
                    (task) => TaskGridItem(
                      task: task,
                    ),
                  )
                  .toList(),
            )
          : Column(
              children: tasks
                  .map(
                    (task) => TaskListItem(
                      task: task,
                      isShowCheck: isShowCheck,
                    ),
                  )
                  .toList(),
            ),
    ],
  );
}
