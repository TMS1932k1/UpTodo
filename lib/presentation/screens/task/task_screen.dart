import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/presentation/widgets/task/detail_task.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                // Save new task's inform
              },
              icon: const FaIcon(
                FontAwesomeIcons.save,
                size: 24,
              ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(kPaddingSmall),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: DetailTask(task: task),
            ),
            SizedBox(
              width: 327,
              child: ElevatedButton(
                onPressed: () {},
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.green),
                    ),
                child: Text(
                  'Completed Task',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
