import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/widgets/auth/login_option_button.dart';

class BottomOption extends StatelessWidget {
  const BottomOption({
    super.key,
    required this.isLogin,
    required this.changeMode,
  });

  final bool isLogin;
  final void Function() changeMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: kPaddingSmall),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '___________________or___________________',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: kPaddingMedium),
          const LoginOptionButton(
            text: 'Login with Google',
            icon: FaIcon(FontAwesomeIcons.google),
          ),
          const SizedBox(height: kPaddingSmall),
          const LoginOptionButton(
            text: 'Login with Apple',
            icon: FaIcon(FontAwesomeIcons.apple),
          ),
          const SizedBox(height: kPaddingMedium),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLogin ? 'Don’t have an account?' : 'Already have an account?',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey,
                    ),
              ),
              GestureDetector(
                onTap: changeMode,
                child: Text(
                  isLogin ? ' Register' : ' Login',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
