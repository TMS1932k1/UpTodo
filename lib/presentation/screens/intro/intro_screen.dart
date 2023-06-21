import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_constant.dart';
import 'package:todo_app/presentation/screens/intro/onboading_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboading();
  }

  /// Delay 5 seconds then navigate to [OnboadingScreen]
  void _navigateToOnboading() async {
    await Future.delayed(const Duration(milliseconds: 5000)).then(
      (value) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnboadingScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(logoImage),
              const SizedBox(height: 19),
              Text(
                'UpTodo',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
