import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimen_constant.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({super.key, this.setIsCompleted});

  final Function(bool)? setIsCompleted;

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  var isToDo = true;

  @override
  Widget build(BuildContext context) {
    // Get height/width of device
    final sizeDevice = MediaQuery.of(context).size;
    final isTablet = sizeDevice.width > 600;

    return Container(
      height: 42,
      width: isTablet ? sizeDevice.width / 2 : double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: kPaddingSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
              child: Container(
                height: double.infinity,
                alignment: Alignment.center,
                color: isToDo ? Theme.of(context).colorScheme.primary : null,
                child: GestureDetector(
                  onTap: () => setState(() {
                    isToDo = true;
                    if (widget.setIsCompleted != null) {
                      widget.setIsCompleted!(false);
                    }
                  }),
                  child: Text(
                    'To do',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
              child: Container(
                height: double.infinity,
                alignment: Alignment.center,
                color: !isToDo ? Theme.of(context).colorScheme.primary : null,
                child: GestureDetector(
                  onTap: () => setState(() {
                    isToDo = false;
                    if (widget.setIsCompleted != null) {
                      widget.setIsCompleted!(true);
                    }
                  }),
                  child: Text(
                    'Completed',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
