import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_bloc.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_event.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_state.dart';
import 'package:todo_app/constants/app_constant.dart';
import 'package:todo_app/presentation/widgets/home/bottom_sheet/new_task_btn_sheet.dart';
import 'package:todo_app/presentation/widgets/home/home_btn_nav_bar.dart';
import 'package:todo_app/presentation/widgets/home/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoadTaskBloc>(context).add(LoadEvent());
  }

  /// Set [currentIndex] by [newIndex]
  /// Update Scaffold's body depend on [homePage] and [currentIndex]
  void setNewIndex(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

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

  /// Show bottom sheet to add new task
  void showAddTaskBottomSheet(bool isTablet) {
    if (!isTablet) {
      showModalBottomSheet(
        context: context,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(16),
            right: Radius.circular(16),
          ),
        ),
        builder: (context) => const NewTaskBtnSheet(),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => const Dialog(
          elevation: 0,
          child: SizedBox(
            width: 450,
            child: NewTaskBtnSheet(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get height/width of device
    final sizeDevice = MediaQuery.of(context).size;
    final isTablet = sizeDevice.width > 600;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocListener<LoadTaskBloc, LoadTasksState>(
          listener: (context, state) {
            if (state is ErrorState) {
              _showSnackBarError('Error in loading tasks');
            }
          },
          child: BlocBuilder<LoadTaskBloc, LoadTasksState>(
            builder: (context, loadState) {
              if (loadState is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              return homePages[currentIndex]['page'];
            },
          ),
        ),
        drawer: isTablet
            ? HomeDrawer(
                width: sizeDevice.width / 3,
                currentIndex: currentIndex,
                setNewIndex: setNewIndex,
              )
            : null,
        floatingActionButton: SizedBox(
          width: 64,
          height: 64,
          child: FloatingActionButton(
            onPressed: () => showAddTaskBottomSheet(isTablet),
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: FaIcon(
              FontAwesomeIcons.plus,
              size: 32,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation:
            !isTablet ? FloatingActionButtonLocation.miniCenterDocked : null,
        bottomNavigationBar: !isTablet
            ? HomeBtnNavBar(
                currentIndex: currentIndex,
                setNewIndex: setNewIndex,
              )
            : null,
      ),
    );
  }
}
