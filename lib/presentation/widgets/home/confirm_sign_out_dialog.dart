import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConfirmSignOutDialog extends StatelessWidget {
  const ConfirmSignOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Sign Out',
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      content: Text(
        'Please confirm to sign out current user',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            if (context.mounted) Navigator.of(context).pop();
          },
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
