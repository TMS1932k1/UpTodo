import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/presentation/widgets/home/calendar/day_item.dart';

class CalendarBar extends StatefulWidget {
  const CalendarBar({super.key});

  @override
  State<CalendarBar> createState() => _CalendarBarState();
}

class _CalendarBarState extends State<CalendarBar> {
  var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 107,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () {
                    // Set tomorow
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.chevronLeft,
                    size: 12,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        DateFormat('MMMM').format(date),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        DateFormat('yyyy').format(date),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Set yeterday
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 12,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: Iterable<int>.generate(7).map((index) {
              final day = date.subtract(
                Duration(days: date.weekday - index - 1),
              );

              final isChose = date.day == day.day &&
                  date.month == day.month &&
                  date.year == day.year;

              return DayItem(
                date: day,
                isChoosed: isChose,
                onClick: (choseDate) {
                  setState(() {
                    date = choseDate;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
