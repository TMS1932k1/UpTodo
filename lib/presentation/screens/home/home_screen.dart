import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/constants/app_constant.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: homePages[currentIndex]['page'],
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          onPressed: () {},
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
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: setNewIndex,
          showSelectedLabels: true,
          selectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.surface,
          items: homePages
              .map(
                (page) => BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: Image.asset(
                        page['icon'],
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  label: page['name'],
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: Image.asset(
                        page['active'],
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
