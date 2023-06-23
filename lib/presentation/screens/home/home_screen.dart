import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/constants/app_constant.dart';
import 'package:todo_app/presentation/widgets/home/home_btn_nav_bar.dart';
import 'package:todo_app/presentation/widgets/home/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentIndex = 0;

  /// Set [currentIndex] by [newIndex]
  /// Update Scaffold's body depend on [homePage] and [currentIndex]
  void setNewIndex(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get height/width of device
    final sizeDevice = MediaQuery.of(context).size;
    final isTablet = sizeDevice.width > 600;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: homePages[currentIndex]['page'],
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
            onPressed: () {
              // Add new index
            },
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: FaIcon(
              FontAwesomeIcons.plus,
              size: 32,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
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
