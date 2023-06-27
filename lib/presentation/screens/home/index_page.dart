import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/presentation/widgets/confirm_dialog.dart';
import 'package:todo_app/presentation/widgets/home/index/show_task_list.dart';
import 'package:todo_app/presentation/widgets/home/index/sign_out_button.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  /// Show alert dialog to confirm sign out current auth
  void _signOut(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: 'Sign Out',
        content: 'Please confirm to sign out current user',
        onConfirm: () async {
          await FirebaseAuth.instance.signOut();
          if (context.mounted) Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: _buildAppbar(context),
      body: const ShowTaskList(),
    );
  }

  /// Build Appbar
  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Index',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      centerTitle: true,
      leadingWidth: 110,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (Scaffold.of(context).hasDrawer)
            IconButton(
              iconSize: 24,
              icon: FaIcon(
                FontAwesomeIcons.bars,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: () {
                // Open Drawer
                Scaffold.of(context).openDrawer();
              },
            ),
        ],
      ),
      actions: [
        SignOutButton(
          firstCharName: FirebaseAuth.instance.currentUser!.email![0],
          onSignOut: () => _signOut(context),
        ),
      ],
    );
  }
}
