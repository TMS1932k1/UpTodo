import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_bloc.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_event.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_state.dart';
import 'package:todo_app/business_logic/cubits/search/search_cubit.dart';
import 'package:todo_app/business_logic/cubits/search/search_state.dart';
import 'package:todo_app/constants/app_constant.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/presentation/widgets/home/index/search_input.dart';
import 'package:todo_app/presentation/widgets/home/index/task_grid_item.dart';
import 'package:todo_app/presentation/widgets/home/index/task_list_item.dart';

class ShowTaskList extends StatefulWidget {
  const ShowTaskList({super.key});

  @override
  State<ShowTaskList> createState() => _ShowTaskListState();
}

class _ShowTaskListState extends State<ShowTaskList> {
  void _showSnackBarError(String mes) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mes),
        duration: const Duration(milliseconds: 2000),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LoadTaskBloc>(context).add(LoadEvent());

    // Get height/width of device
    final sizeDevice = MediaQuery.of(context).size;
    final isTablet = sizeDevice.width > 600;

    return BlocListener<LoadTaskBloc, LoadTasksState>(
      listener: (context, state) {
        if (state is ErrorState) _showSnackBarError('Error in loading tasks');
      },
      child: BlocBuilder<LoadTaskBloc, LoadTasksState>(
        builder: (context, loadState) {
          if (loadState is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (loadState is ErrorState) {
            return _buildEmptyScreen(context);
          }

          if (loadState.tasks == null || loadState.tasks!.isEmpty) {
            return _buildEmptyScreen(context);
          }

          return Container(
            padding: const EdgeInsets.all(kPaddingSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchInput(
                  onSearch: (title) {
                    // Search tasks with name
                    BlocProvider.of<SearchCubit>(context).searchWithTitle(
                      title,
                      loadState.tasks!,
                    );
                  },
                ),
                const SizedBox(height: kPaddingMedium),
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, searchState) {
                    if (searchState.searchs == null) {
                      return Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (loadState.toDo != null &&
                                  loadState.toDo!.isNotEmpty)
                                _buildDefaultTaskList(
                                  context: context,
                                  isTablet: isTablet,
                                  tasks: loadState.toDo!,
                                  title: 'To Do',
                                ),
                              if (loadState.completeDo != null &&
                                  loadState.completeDo!.isNotEmpty)
                                const SizedBox(height: kPaddingMedium),
                              if (loadState.completeDo != null &&
                                  loadState.completeDo!.isNotEmpty)
                                _buildDefaultTaskList(
                                  context: context,
                                  isTablet: isTablet,
                                  tasks: loadState.completeDo!,
                                  title: 'Completed Tasks',
                                  isShowCheck: true,
                                ),
                              if (loadState.missDo != null &&
                                  loadState.missDo!.isNotEmpty)
                                const SizedBox(height: kPaddingMedium),
                              if (loadState.missDo != null &&
                                  loadState.missDo!.isNotEmpty)
                                _buildDefaultTaskList(
                                  context: context,
                                  isTablet: isTablet,
                                  tasks: loadState.missDo!,
                                  title: 'Miss Tasks',
                                  isShowCheck: true,
                                ),
                            ],
                          ),
                        ),
                      );
                    } else if (searchState.searchs!.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Text('Not have task with this title'),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildDefaultTaskList(
                                context: context,
                                isTablet: isTablet,
                                tasks: searchState.searchs!,
                                title: 'Results',
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
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

Widget _buildEmptyScreen(BuildContext context) {
  return Center(
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
}

Widget _buildDefaultTaskList({
  required BuildContext context,
  required List<Task> tasks,
  required bool isTablet,
  required String title,
  bool isShowCheck = false,
  Widget? sortButton,
}) {
  return Column(
    children: [
      _buildTitle(context, title),
      const SizedBox(height: kPaddingSmall),
      if (sortButton != null) const SizedBox(height: kPaddingSmall),
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
