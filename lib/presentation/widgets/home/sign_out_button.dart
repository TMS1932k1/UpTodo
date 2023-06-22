import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimen_constant.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    super.key,
    required this.firstCharName,
    this.onSignOut,
  });

  final String firstCharName;
  final Function()? onSignOut;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onSignOut,
        child: Container(
          width: 42,
          height: 42,
          margin: const EdgeInsets.only(right: kPaddingSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(42),
            color: Theme.of(context).colorScheme.primary,
          ),
          alignment: Alignment.center,
          child: Text(
            firstCharName.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
