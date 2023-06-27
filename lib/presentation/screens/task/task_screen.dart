import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/business_logic/blocs/del_task/del_task_bloc.dart';
import 'package:todo_app/business_logic/blocs/del_task/del_task_state.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_bloc.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_event.dart';
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
    return BlocListener<DelTaskBloc, DelTaskState>(
      listener: (context, state) {
        if (state is DelSuccessState) {
          // Show snack to notice success
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Delete task successfully'),
              duration: Duration(milliseconds: 2000),
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
      child: BlocBuilder<DelTaskBloc, DelTaskState>(
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
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
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                backgroundColor: const MaterialStatePropertyAll(
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
