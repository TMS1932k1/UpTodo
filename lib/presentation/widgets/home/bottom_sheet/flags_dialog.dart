import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/presentation/widgets/home/bottom_sheet/flag_grid_item.dart';

class FlagsDialog extends StatefulWidget {
  const FlagsDialog({
    super.key,
    this.flag,
    required this.onSaved,
  });

  final int? flag;
  final Function(int?) onSaved;

  @override
  State<FlagsDialog> createState() => _FlagsDialogState();
}

class _FlagsDialogState extends State<FlagsDialog> {
  int? addFlag;

  @override
  void initState() {
    super.initState();
    addFlag = widget.flag;
  }

  /// Set [addFlag] with onclicked flag
  /// If onClick agained will set null to [addFlag]
  void setSelectedFlag(int flag) {
    setState(() {
      if (addFlag == flag) {
        addFlag = null;
      } else {
        addFlag = flag;
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
              'Task Priority',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: kPaddingSmall),
            Divider(
              height: 2,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(height: kPaddingSmall),
            MasonryGrid(
              column: 4,
              mainAxisSpacing: kPaddingSmall,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List<Widget>.generate(
                10,
                (index) => FlagGridItem(
                  flag: index + 1,
                  isSelected: index + 1 == addFlag,
                  onClicked: setSelectedFlag,
                ),
              ).toList(),
            ),
            const SizedBox(height: kPaddingMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => widget.onSaved(addFlag),
                      child: const Text('Save'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
