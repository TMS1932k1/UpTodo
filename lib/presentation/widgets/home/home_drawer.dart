import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_constant.dart';
import 'package:todo_app/constants/dimen_constant.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.width,
    required this.currentIndex,
    required this.setNewIndex,
  });

  final double width;
  final int currentIndex;
  final Function(int) setNewIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      width: width,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kPaddingMedium,
              horizontal: kPaddingSmall,
            ),
            child: Text(
              'UpTodo',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          ...homePages.map(
            (page) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kPaddingSmall,
              ),
              child: ListTile(
                leading: Image.asset(
                  currentIndex == homePages.indexOf(page)
                      ? page['active']
                      : page['icon'],
                  width: 24,
                  height: 24,
                ),
                title: Text(
                  page['name'],
                  style: currentIndex == homePages.indexOf(page)
                      ? Theme.of(context).textTheme.labelSmall
                      : Theme.of(context).textTheme.bodyMedium,
                ),
                onTap: () {
                  setNewIndex(homePages.indexOf(page));
                  Scaffold.of(context).closeDrawer();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
