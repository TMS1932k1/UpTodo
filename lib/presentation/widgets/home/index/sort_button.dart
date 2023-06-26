import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimen_constant.dart';

class SortButton extends StatefulWidget {
  const SortButton({
    super.key,
    required this.sortOptions,
    required this.onSort,
  });

  final List<String> sortOptions;
  final void Function(int) onSort;

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).colorScheme.surface,
      ),
      height: 31,
      padding: const EdgeInsets.symmetric(horizontal: kPaddingSmall),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          elevation: 0,
          iconSize: 16,
          value: widget.sortOptions[currentIndex],
          items: widget.sortOptions
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(
                    e,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null &&
                currentIndex != widget.sortOptions.indexOf(value)) {
              setState(() {
                currentIndex = widget.sortOptions.indexOf(value);
              });
              widget.onSort(widget.sortOptions.indexOf(value));
            }
          },
        ),
      ),
    );
  }
}
