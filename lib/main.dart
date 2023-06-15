import 'package:flutter/material.dart';
import 'package:todo_app/screens/intro/intro_screen.dart';
import 'package:todo_app/themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeLight,
      darkTheme: themeDark,
      debugShowCheckedModeBanner: false,
      home: const IntroScreen(),
    );
  }
}
