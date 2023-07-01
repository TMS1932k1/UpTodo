import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayItem extends StatelessWidget {
  const DayItem({
    super.key,
    required this.date,
    this.onClick,
    required this.isChoosed,
  });

  final DateTime date;
  final Function(DateTime)? onClick;
  final bool isChoosed;

  @override
  Widget build(BuildContext context) {
    final isWeekend =
        date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;

    return GestureDetector(
      onTap: onClick != null ? () => onClick!(date) : null,
      child: Container(
        width: 39,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isChoosed
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.background,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              DateFormat('EEE').format(date).toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: isWeekend
                        ? Colors.red
                        : Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            Text(
              DateFormat('dd').format(date).toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
