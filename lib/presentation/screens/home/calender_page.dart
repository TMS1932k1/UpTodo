import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/presentation/widgets/home/calendar/calendar_bar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Calendar',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        leading: Scaffold.of(context).hasDrawer
            ? IconButton(
                iconSize: 24,
                icon: FaIcon(
                  FontAwesomeIcons.bars,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                onPressed: () {
                  // Open Drawer
                  Scaffold.of(context).openDrawer();
                },
              )
            : null,
      ),
      body: Container(
        child: Column(
          children: [
            const CalendarBar(),
          ],
        ),
      ),
    );
  }
}
