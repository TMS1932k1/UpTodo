import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlagGridItem extends StatelessWidget {
  const FlagGridItem({
    super.key,
    required this.flag,
    this.isSelected = false,
    this.onClicked,
  });

  final int flag;
  final bool isSelected;
  final Function(int)? onClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: isSelected
          ? BoxDecoration(
              border: Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              borderRadius: BorderRadius.circular(4),
            )
          : null,
      padding:
          isSelected ? const EdgeInsets.all(4.0) : const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: onClicked != null ? () => onClicked!(flag) : null,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).colorScheme.surface,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FaIcon(
                FontAwesomeIcons.flag,
                size: 20,
              ),
              const SizedBox(height: 6),
              Text(
                flag.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
