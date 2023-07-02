import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/presentation/widgets/home/calendar/day_item.dart';

class CalendarBar extends StatefulWidget {
  const CalendarBar({
    super.key,
    this.setDate,
  });

  final Function(DateTime date)? setDate;

  @override
  State<CalendarBar> createState() => _CalendarBarState();
}

class _CalendarBarState extends State<CalendarBar> {
  var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // Get height/width of device
    final sizeDevice = MediaQuery.of(context).size;
    final isTablet = sizeDevice.width > 600;

    return Container(
      height: 107,
      width: isTablet ? sizeDevice.width * 2 / 3 : double.infinity,
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
                    // Set next week
                    setState(() {
                      date = date.subtract(Duration(days: date.weekday));
                      if (widget.setDate != null) {
                        widget.setDate!(date);
                      }
                    });
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.chevronLeft,
                    size: 12,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: widget.setDate != null
                        ? () {
                            setState(() {
                              date = DateTime.now();
                              widget.setDate!(date);
                            });
                          }
                        : null,
                    child: Column(
                      children: [
                        Text(
                          DateFormat('MMMM').format(date),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          DateFormat('yyyy').format(date),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Set last week
                    setState(() {
                      date = date.add(Duration(days: 7 - date.weekday + 1));
                      if (widget.setDate != null) {
                        widget.setDate!(date);
                      }
                    });
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
                    if (widget.setDate != null) {
                      widget.setDate!(day);
                    }
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
