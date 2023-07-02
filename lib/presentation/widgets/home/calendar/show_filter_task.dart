import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:todo_app/business_logic/cubits/calender/filter_cubit.dart';
import 'package:todo_app/business_logic/cubits/calender/filter_state.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/presentation/screens/task/task_screen.dart';
import 'package:todo_app/presentation/widgets/home/task_grid_item.dart';
import 'package:todo_app/presentation/widgets/home/task_list_item.dart';

class ShowFilterTask extends StatelessWidget {
  const ShowFilterTask({super.key});

  @override
  Widget build(BuildContext context) {
    // Get height/width of device
    final sizeDevice = MediaQuery.of(context).size;
    final isTablet = sizeDevice.width > 600;

    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        return Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kPaddingSmall,
            ),
            child: SingleChildScrollView(
              child: isTablet
                  ? MasonryGrid(
                      crossAxisSpacing: kPaddingSmall,
                      column: 3,
                      children: state.tasks
                          .map(
                            (task) => TaskGridItem(
                              task: task,
                              isShowCheck: false,
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
                      children: state.tasks
                          .map(
                            (task) => TaskListItem(
                              task: task,
                              isShowCheck: false,
                              onClicked: (task) => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TaskScreen(task: task),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ),
        );
      },
    );
  }
}
