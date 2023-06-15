import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/screens/auth/auth_screem.dart';
import 'package:todo_app/widgets/intro/title_subtitle_text.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Navigate to [AuthScreen]
    void navigateToAuthScreen(bool isLogin) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AuthScreen(
            isLogin: isLogin,
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            vertical: kPaddingLarge,
            horizontal: kPaddingSmall,
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TitleSubtitleText(
                title: 'Welcome to UpTodo',
                subtitle:
                    'Please login to your account or create new account to continue',
              ),
              Column(
                children: [
                  SizedBox(
                    width: 327,
                    child: ElevatedButton(
                      onPressed: () => navigateToAuthScreen(true),
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                  const SizedBox(height: kPaddingSmall),
                  SizedBox(
                    width: 327,
                    child: ElevatedButton(
                      onPressed: () => navigateToAuthScreen(false),
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style!
                          .copyWith(
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
                      child: Text(
                        'CREATE ACCOUNT',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
