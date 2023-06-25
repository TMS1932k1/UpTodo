import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/constants/app_constant.dart';
import 'package:todo_app/data/models/category.dart';
import 'package:todo_app/presentation/widgets/home/bottom_sheet/category_grid_item.dart';

class CategoriesDialog extends StatefulWidget {
  const CategoriesDialog({
    super.key,
    this.category,
    required this.selectCategory,
  });

  final Category? category;
  final Function(Category?) selectCategory;

  @override
  State<CategoriesDialog> createState() => _CategoriesDialogState();
}

class _CategoriesDialogState extends State<CategoriesDialog> {
  Category? addCategory;

  @override
  void initState() {
    super.initState();
    addCategory = widget.category;
  }

  /// Set [addCategory] with onclicked category
  /// If onClick agained will set null to [addCategory]
  void setSelectedCategory(Category category) {
    setState(() {
      if (addCategory == category) {
        addCategory = null;
      } else {
        addCategory = category;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get height/width of device
    final sizeDevice = MediaQuery.of(context).size;
    final isTablet = sizeDevice.width > 600;

    return Dialog(
      elevation: 0,
      child: Container(
        width: isTablet ? 370 : double.infinity,
        padding: const EdgeInsets.all(kPaddingSmall),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose Category',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: kPaddingSmall),
            Divider(
              height: 2,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(height: kPaddingSmall),
            MasonryGrid(
              column: 3,
              mainAxisSpacing: kPaddingSmall,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: categogies
                  .map(
                    (category) => CategoryGridItem(
                      category: category,
                      onClick: setSelectedCategory,
                      isSelected: category == addCategory,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: kPaddingMedium),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => widget.selectCategory(addCategory),
                child: const Text('Add Category'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
