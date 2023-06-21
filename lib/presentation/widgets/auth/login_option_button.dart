import 'package:flutter/material.dart';

class LoginOptionButton extends StatelessWidget {
  const LoginOptionButton({
    super.key,
    required this.text,
    required this.icon,
    this.onClick,
  });

  final String text;
  final Widget icon;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      child: ElevatedButton.icon(
        onPressed: onClick,
        icon: icon,
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              backgroundColor: const MaterialStatePropertyAll(
                Colors.transparent,
              ),
              side: MaterialStatePropertyAll(
                BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
            ),
        label: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
          overflow: TextOverflow.clip,
          maxLines: 1,
        ),
      ),
    );
  }
}
