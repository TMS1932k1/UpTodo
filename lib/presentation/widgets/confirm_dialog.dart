import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  final String title;
  final String content;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: onConfirm,
          child: Text(
            'Confirm',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.red,
                ),
          ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
