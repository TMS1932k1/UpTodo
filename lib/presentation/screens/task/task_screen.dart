import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/business_logic/blocs/edit_task/edit_task_bloc.dart';
import 'package:todo_app/business_logic/blocs/edit_task/edit_task_event.dart';
import 'package:todo_app/business_logic/blocs/edit_task/edit_task_state.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_bloc.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_event.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/presentation/widgets/task/detail_task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Map<String, dynamic>? changes;

  @override
  Widget build(BuildContext context) {
    /// Add CompleteEvent to Bloc
    void completeTask(Task task) {
      BlocProvider.of<EditTaskBloc>(context).add(CompleteEvent(
        user: FirebaseAuth.instance.currentUser!,
        id: task.id,
      ));
    }

    /// Add EditEvent to Bloc
    void editedTask(Task task) {
      BlocProvider.of<EditTaskBloc>(context).add(EditEvent(
        user: FirebaseAuth.instance.currentUser!,
        id: task.id,
        changes: changes!,
      ));
    }

    return BlocListener<EditTaskBloc, EditTaskState>(
      listener: (context, state) {
        if (state is EditSuccessState) {
          // Show snack to notice success
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.mesSuccess),
              duration: const Duration(milliseconds: 2000),
              backgroundColor: Colors.green,
            ),
          );

          // Load again list
          BlocProvider.of<LoadTaskBloc>(context).add(LoadEvent());

          // Pop navigator
          Navigator.of(context).pop();
        }

        if (state is ErrorState) {
          // Show snack to notice failured
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Delete task failured'),
              duration: Duration(milliseconds: 2000),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<EditTaskBloc, EditTaskState>(
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Theme.of(context).colorScheme.background,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                      onPressed: changes != null
                          ? () => editedTask(widget.task)
                          : null,
                      icon: FaIcon(
                        FontAwesomeIcons.floppyDisk,
                        size: 24,
                        color: changes != null
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
                body: Container(
                  padding: const EdgeInsets.all(kPaddingSmall),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: DetailTask(
                          task: widget.task,
                          setChanged: (map) {
                            setState(() {
                              changes = map;
                            });
                          },
                        ),
                      ),
                      if (widget.task.isCompleted)
                        const FaIcon(
                          FontAwesomeIcons.check,
                          color: Colors.green,
                        ),
                      if (!widget.task.isCompleted)
                        SizedBox(
                          width: 327,
                          child: ElevatedButton(
                            onPressed: () => completeTask(widget.task),
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.green),
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
              ),
              if (state is LoadingState)
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
                )
            ],
          );
        },
      ),
    );
  }
}
