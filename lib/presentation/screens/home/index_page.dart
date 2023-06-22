import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/presentation/widgets/home/confirm_sign_out_dialog.dart';
import 'package:todo_app/presentation/widgets/home/sign_out_button.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  /// Show alert dialog to confirm sign out current auth
  void _signOut(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => const ConfirmSignOutDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Index',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.filter,
            size: 24,
          ),
          onPressed: () {},
        ),
        actions: [
          SignOutButton(
            firstCharName: FirebaseAuth.instance.currentUser!.email![0],
            onSignOut: () => _signOut(context),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
