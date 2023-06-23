import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/data/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    this.onClick,
    this.isSelected = false,
  });

  final Category category;
  final Function(Category)? onClick;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          height: 64,
          width: 64,
          decoration: isSelected
              ? BoxDecoration(
                  border: Border.all(width: 2, color: category.colorBg),
                  borderRadius: BorderRadius.circular(4),
                )
              : null,
          padding: isSelected
              ? const EdgeInsets.all(4.0)
              : const EdgeInsets.all(0.0),
          child: GestureDetector(
            onTap: onClick != null ? () => onClick!(category) : null,
            child: Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: category.colorBg,
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: FaIcon(
                category.icon,
                size: 32,
                color: category.colorIcon,
              ),
            ),
          ),
        ),
        const SizedBox(height: kPaddingSmall),
        Text(
          category.title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
