import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_bloc.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_state.dart';
import 'package:todo_app/business_logic/cubits/search/search_cubit.dart';
import 'package:todo_app/business_logic/cubits/search/search_state.dart';
import 'package:todo_app/business_logic/cubits/sort/sort_cubit.dart';
import 'package:todo_app/business_logic/cubits/sort/sort_state.dart';
import 'package:todo_app/constants/app_constant.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/presentation/screens/task/task_screen.dart';
import 'package:todo_app/presentation/widgets/home/index/search_input.dart';
import 'package:todo_app/presentation/widgets/home/index/sort_button.dart';
import 'package:todo_app/presentation/widgets/home/index/task_grid_item.dart';
import 'package:todo_app/presentation/widgets/home/index/task_list_item.dart';

class ShowTaskList extends StatefulWidget {
  const ShowTaskList({super.key});

  @override
  State<ShowTaskList> createState() => _ShowTaskListState();
}

class _ShowTaskListState extends State<ShowTaskList> {
  @override
  Widget build(BuildContext context) {
    // Get height/width of device
    final sizeDevice = MediaQuery.of(context).size;
    final isTablet = sizeDevice.width > 600;
    final loadState = BlocProvider.of<LoadTaskBloc>(context).state;

    if (loadState is ErrorState ||
        loadState.tasks == null ||
        loadState.tasks!.isEmpty) {
      return _buildEmptyScreen(context);
    }

    if (loadState.toDo != null && loadState.toDo!.isNotEmpty) {
      BlocProvider.of<SortCubit>(context).sortDefault(loadState.toDo!);
    }

    /// Sort with [index]
    ///  + 0 / default: Priority
    ///  + 1: Date
    ///  + 2: A-Z
    void sortWithIndex(int index, List<Task> tasks) {
      switch (index) {
        case 1:
          BlocProvider.of<SortCubit>(context).sortDate(tasks);
          break;
        case 2:
          BlocProvider.of<SortCubit>(context).sortAZ(tasks);
          break;
        default:
          BlocProvider.of<SortCubit>(context).sortDefault(tasks);
      }
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
                          BlocBuilder<SortCubit, SortState>(
                            builder: (context, sortState) =>
                                _buildDefaultTaskList(
                              context: context,
                              isTablet: isTablet,
                              tasks: sortState.sorted,
                              title: 'To Do',
                              sortButton: SortButton(
                                sortOptions: const [
                                  'Priority',
                                  'Date',
                                  'A-Z',
                                ],
                                onSort: (index) => sortWithIndex(
                                  index,
                                  loadState.toDo!,
                                ),
                              ),
                            ),
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
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildTitle(context, title),
      const SizedBox(height: kPaddingSmall),
      if (sortButton != null) sortButton,
      isTablet
          ? MasonryGrid(
              crossAxisSpacing: kPaddingSmall,
              column: 3,
              children: tasks
                  .map(
                    (task) => TaskGridItem(
                      task: task,
                      isShowCheck: isShowCheck,
                      onClicked: (task) => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TaskScreen(task: task),
                        ),
                      ),
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
                      onClicked: (task) => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TaskScreen(task: task),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
    ],
  );
}
