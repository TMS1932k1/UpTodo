import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/business_logic/cubits/auth/auth_loading_cubit.dart';
import 'package:todo_app/business_logic/cubits/auth/auth_loading_state.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/data/repositories/auth_firebase.dart';
import 'package:todo_app/presentation/widgets/auth/login_option_button.dart';

class BottomOption extends StatelessWidget {
  const BottomOption({
    super.key,
    required this.isLogin,
    required this.changeMode,
  });

  final bool isLogin;
  final void Function() changeMode;

  void showSnackBarError(BuildContext context, String mes) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mes),
        duration: const Duration(milliseconds: 2000),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void signInWithGoogleAccount() async {
      // Set state to start loading
      BlocProvider.of<AuthLoadingCubit>(context).startLoading();

      final error = await signInWithGoogle();

      if (context.mounted) {
        if (error != null) {
          showSnackBarError(context, error);
        }

        // Set state to stop loading
        BlocProvider.of<AuthLoadingCubit>(context).stopLoading();
      }
    }

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
          BlocBuilder<AuthLoadingCubit, AuthLoadingState>(
            builder: (context, state) {
              void Function()? onClick;

              if (!state.isLoading) {
                onClick = signInWithGoogleAccount;
              }

              return LoginOptionButton(
                text: 'Login with Google',
                icon: const FaIcon(FontAwesomeIcons.google),
                onClick: onClick,
              );
            },
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
