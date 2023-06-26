import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/constants/app_constant.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/presentation/widgets/home/category_tag.dart';
import 'package:todo_app/presentation/widgets/home/datetime_tag.dart';
import 'package:todo_app/presentation/widgets/home/flag_tag.dart';

class DetailTask extends StatelessWidget {
  const DetailTask({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: kPaddingSmall),
                      if (task.description != null)
                        Text(
                          task.description!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          // Edit title and decription
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.edit,
                          size: 20,
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kPaddingLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.clock,
                      size: 20,
                    ),
                    const SizedBox(width: kPaddingSmall),
                    Text(
                      'Task Time:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                if (task.dateTime != null)
                  GestureDetector(
                    onTap: () {
                      // Edit task's date
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      padding: const EdgeInsets.all(
                        kPaddingSmall,
                      ),
                      child: DateTimeTag(
                        dateTime: DateTime.fromMillisecondsSinceEpoch(
                          task.dateTime!.millisecondsSinceEpoch,
                        ),
                      ),
                    ),
                  ),
                if (task.dateTime == null)
                  ElevatedButton(
                    onPressed: () {
                      // Edit task's date
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
                    child: const Text('Add'),
                  ),
              ],
            ),
            const SizedBox(height: kPaddingMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.tag,
                      size: 20,
                    ),
                    const SizedBox(width: kPaddingSmall),
                    Text(
                      'Task Categoty:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                if (task.category != null)
                  GestureDetector(
                    onTap: () {
                      // Edit task's date
                    },
                    child: CategoryTag(
                      category: categogies[task.category! - 1],
                      onClick: () {
                        // Edit task's category
                      },
                    ),
                  ),
                if (task.category == null)
                  ElevatedButton(
                    onPressed: () {
                      // Edit task's category
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
                    child: const Text('Add'),
                  ),
              ],
            ),
            const SizedBox(height: kPaddingMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.flag,
                      size: 20,
                    ),
                    const SizedBox(width: kPaddingSmall),
                    Text(
                      'Task Priority:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                if (task.flag != null)
                  GestureDetector(
                    onTap: () {
                      // Edit task's flag
                    },
                    child: FlagTag(
                      flag: task.flag!,
                    ),
                  ),
                if (task.flag == null)
                  ElevatedButton(
                    onPressed: () {
                      // Edit task's flag
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
                    child: const Text('Add'),
                  ),
              ],
            ),
            const SizedBox(height: kPaddingMedium),
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.trash,
                  color: Colors.red,
                  size: 20,
                ),
                const SizedBox(width: kPaddingSmall),
                TextButton(
                  onPressed: () {
                    // Delete task
                  },
                  child: Text(
                    'Delete Task',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.red,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
