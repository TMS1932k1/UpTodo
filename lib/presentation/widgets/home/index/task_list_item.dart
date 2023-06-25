import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/constants/app_constant.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/presentation/widgets/home/category_tag.dart';
import 'package:todo_app/presentation/widgets/home/datetime_tag.dart';
import 'package:todo_app/presentation/widgets/home/flag_tag.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.task,
    this.isShowCheck = false,
  });

  final Task task;
  final bool isShowCheck;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).colorScheme.surface,
      ),
      padding: const EdgeInsets.all(kPaddingSmall),
      margin: const EdgeInsets.symmetric(vertical: kPaddingSmall / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isShowCheck)
                FaIcon(
                  task.isCompleted
                      ? FontAwesomeIcons.circleCheck
                      : FontAwesomeIcons.circleXmark,
                  color: task.isCompleted ? Colors.green : Colors.red,
                  size: 14,
                ),
              if (isShowCheck) const SizedBox(width: 6),
              Text(
                task.title,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          const SizedBox(height: kPaddingSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (task.dateTime != null)
                Expanded(
                  child: DateTimeTag(
                    dateTime: DateTime.fromMillisecondsSinceEpoch(
                      task.dateTime!.millisecondsSinceEpoch,
                    ),
                  ),
                ),
              Row(
                children: [
                  if (task.category != null)
                    CategoryTag(category: categogies[task.category! - 1]),
                  if (task.flag != null) const SizedBox(width: kPaddingSmall),
                  if (task.flag != null) FlagTag(flag: task.flag!),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
