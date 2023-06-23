import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_constant.dart';

class HomeBtnNavBar extends StatelessWidget {
  const HomeBtnNavBar({
    super.key,
    required this.currentIndex,
    this.setNewIndex,
  });

  final int currentIndex;
  final Function(int)? setNewIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: setNewIndex,
        showSelectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.surface,
        items: homePages
            .map(
              (page) => BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Image.asset(
                    page['icon'],
                    width: 24,
                    height: 24,
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
    );
  }
}
