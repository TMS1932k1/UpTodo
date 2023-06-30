import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/presentation/widgets/cus_text_field.dart';

class EditTitleDescriptionDialog extends StatefulWidget {
  const EditTitleDescriptionDialog({
    super.key,
    required this.title,
    this.decription,
    required this.popReturn,
  });

  final String title;
  final String? decription;
  final Function(String, String?) popReturn;

  @override
  State<EditTitleDescriptionDialog> createState() =>
      _EditTitleDescriptionDialogState();
}

class _EditTitleDescriptionDialogState
    extends State<EditTitleDescriptionDialog> {
  String? _title;
  String? _description;
  final GlobalKey<FormState> _form = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Assign init value with task
    _title = widget.title;
    _description = widget.decription;
  }

  /// Validate value then up Firebase cloundstore
  void onSaved() async {
    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();
    widget.popReturn(_title!, _description);
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
              'Title And Description',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: kPaddingSmall),
            Divider(
              height: 2,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(height: kPaddingSmall),
            Form(
              key: _form,
              child: Column(
                children: [
                  CusTextField(
                    maxLength: 30,
                    isObscure: false,
                    hint: "Enter task's title",
                    onSaved: (value) {
                      _title = value;
                    },
                    text: _title,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter title';
                      }

                      if (value.trim().length > 30) {
                        return 'Lenght of title must be less 30 char';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: kPaddingSmall),
                  CusTextField(
                    maxLength: 100,
                    isObscure: false,
                    hint: "Enter decription",
                    onSaved: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        _description = value;
                      }
                    },
                    text: _description,
                    validator: (value) {
                      if (value != null && value.trim().length > 100) {
                        return 'Lenght of desciption must be less 100 char';
                      }
                      return null;
                    },
                  ),
                ],
              ),
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
                      onPressed: onSaved,
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
