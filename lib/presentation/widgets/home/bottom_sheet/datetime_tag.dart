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
    return GestureDetector(
      onTap: onClick,
      child: Text(
        DateFormat('yyyy/MM/dd – kk:mm').format(dateTime),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
