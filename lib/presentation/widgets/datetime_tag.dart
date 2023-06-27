import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeTag extends StatelessWidget {
  const DateTimeTag({
    super.key,
    required this.dateTime,
    this.onClick,
  });

  final DateTime dateTime;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    // Check datetime is same as today
    final bool isToday = (dateTime.day == DateTime.now().day &&
        dateTime.month == DateTime.now().month &&
        dateTime.year == DateTime.now().year);

    return GestureDetector(
      onTap: onClick,
      child: Text(
        isToday
            ? 'Today - ${DateFormat('kk:mm').format(dateTime)}'
            : DateFormat('yyyy/MM/dd – kk:mm').format(dateTime),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
