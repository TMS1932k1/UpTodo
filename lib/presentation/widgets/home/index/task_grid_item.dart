import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_constant.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/presentation/widgets/home/category_tag.dart';
import 'package:todo_app/presentation/widgets/home/datetime_tag.dart';
import 'package:todo_app/presentation/widgets/home/flag_tag.dart';

class TaskGridItem extends StatelessWidget {
  const TaskGridItem({
    super.key,
    required this.task,
  });

  final Task task;

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
          Text(
            task.title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (task.category != null || task.flag != null)
            const SizedBox(height: kPaddingSmall),
          Row(
            children: [
              if (task.category != null)
                CategoryTag(category: categogies[task.category! - 1]),
              if (task.category != null) const SizedBox(width: kPaddingSmall),
              if (task.flag != null) FlagTag(flag: task.flag!),
            ],
          ),
          if (task.description != null) const SizedBox(height: 6),
          if (task.description != null) const Divider(thickness: 2),
          if (task.description != null) const SizedBox(height: 4),
          if (task.description != null)
            Text(
              task.description!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          if (task.dateTime != null) const SizedBox(height: kPaddingMedium),
          if (task.dateTime != null)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DateTimeTag(
                  dateTime: DateTime.fromMillisecondsSinceEpoch(
                    task.dateTime!.millisecondsSinceEpoch,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
