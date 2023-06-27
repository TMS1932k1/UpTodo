import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/business_logic/blocs/del_task/del_task_bloc.dart';
import 'package:todo_app/business_logic/blocs/del_task/del_task_event.dart';
import 'package:todo_app/constants/app_constant.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/presentation/widgets/categories_dialog.dart';
import 'package:todo_app/presentation/widgets/confirm_dialog.dart';
import 'package:todo_app/presentation/widgets/category_tag.dart';
import 'package:todo_app/presentation/widgets/datetime_tag.dart';
import 'package:todo_app/presentation/widgets/flag_tag.dart';
import 'package:todo_app/presentation/widgets/flags_dialog.dart';

class DetailTask extends StatefulWidget {
  const DetailTask({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<DetailTask> createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  String tempTitle = '';
  String? tempDecription;
  Timestamp? tempDateTime;
  int? tempIdCategory;
  int? tempFlag;

  @override
  void initState() {
    super.initState();

    // Assign temp value with task
    tempTitle = widget.task.title;
    tempDecription = widget.task.description;
    tempDateTime = widget.task.dateTime;
    tempIdCategory = widget.task.category;
    tempFlag = widget.task.flag;
  }

  /// Compare task's details with temp's values
  bool isChanged() {
    return (tempTitle != widget.task.title) ||
        (tempDecription != widget.task.description) ||
        (tempDateTime != widget.task.dateTime) ||
        (tempIdCategory != widget.task.category) ||
        (tempFlag != widget.task.flag);
  }

  /// Show dialog confirm to delete task with [id]
  void delTask(String id) async {
    await showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: 'Confirm Delete Task',
        content: 'Are you sure about deleting this task?',
        onConfirm: () async {
          BlocProvider.of<DelTaskBloc>(context).add(
            DelEvent(
              user: FirebaseAuth.instance.currentUser!,
              id: id,
            ),
          );
          // Pop dialog
          Navigator.of(context).pop();
        },
      ),
    );
  }

  /// Show dialog choose priority flag [tempFlag]
  void showFlagDialog() async {
    await showDialog(
      context: context,
      builder: (context) => FlagsDialog(
        onSaved: (flag) {
          setState(() {
            tempFlag = flag;
          });
          Navigator.of(context).pop();
        },
        flag: tempFlag,
      ),
    );
  }

  /// Set [_datetime] with [date] and [time] to add task's datetime
  void showAddDateTimePicker() async {
    // Set date
    DateTime? convert = tempDateTime != null
        ? DateTime.fromMillisecondsSinceEpoch(
            tempDateTime!.millisecondsSinceEpoch)
        : null;
    DateTime? date = convert;
    date = await showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 30),
      ),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (date == null) return;

    // Set time
    TimeOfDay? time = convert != null ? TimeOfDay.fromDateTime(convert) : null;
    time = await showTimePicker(
      context: context,
      initialTime: time ?? TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (time == null) return;

    // Set datetime
    setState(() {
      tempDateTime = Timestamp.fromDate(
        DateTime(
          date!.year,
          date.month,
          date.day,
          time!.hour,
          time.minute,
        ),
      );
    });
  }

  /// Show dialog choose category [tempIdCategory]
  void showCategoryDialog() async {
    await showDialog(
      context: context,
      builder: (context) => CategoriesDialog(
        selectCategory: (category) {
          setState(() {
            tempIdCategory = category?.id;
          });
          Navigator.of(context).pop();
        },
        category:
            tempIdCategory != null ? categogies[tempIdCategory! - 1] : null,
      ),
    );
  }

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
                        tempTitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: kPaddingSmall),
                      if (tempDecription != null)
                        Text(
                          tempDecription!,
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
                if (tempDateTime != null)
                  GestureDetector(
                    onTap: showAddDateTimePicker,
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
                          tempDateTime!.millisecondsSinceEpoch,
                        ),
                      ),
                    ),
                  ),
                if (tempDateTime == null)
                  ElevatedButton(
                    onPressed: showAddDateTimePicker,
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
                if (tempIdCategory != null)
                  GestureDetector(
                    onTap: () {
                      // Edit task's date
                    },
                    child: CategoryTag(
                      category: categogies[tempIdCategory! - 1],
                      onClick: showCategoryDialog,
                    ),
                  ),
                if (tempIdCategory == null)
                  ElevatedButton(
                    onPressed: showCategoryDialog,
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
                if (tempFlag != null)
                  GestureDetector(
                    onTap: showFlagDialog,
                    child: FlagTag(
                      flag: tempFlag!,
                    ),
                  ),
                if (tempFlag == null)
                  ElevatedButton(
                    onPressed: showFlagDialog,
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
                  onPressed: () => delTask(widget.task.id),
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
