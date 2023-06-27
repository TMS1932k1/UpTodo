import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/data/models/category.dart';

class CategoryTag extends StatelessWidget {
  const CategoryTag({
    super.key,
    required this.category,
    this.onClick,
  });

  final Category category;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 29,
        decoration: BoxDecoration(
          color: category.colorBg,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              category.icon,
              color: category.colorIcon,
              size: 14,
            ),
            const SizedBox(width: 6),
            Text(
              category.title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
