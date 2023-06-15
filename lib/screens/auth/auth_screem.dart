import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/widgets/auth/bottom_option.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
    this.isLogin = true,
  });

  final bool isLogin;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool _isLogin;

  @override
  void initState() {
    super.initState();
    _isLogin = widget.isLogin;
  }

  /// Change [_isLogin] mode
  void _changeMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isLogin ? 'Login' : 'Register',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Expanded(child: Container()),
            BottomOption(
              isLogin: _isLogin,
              changeMode: _changeMode,
            ),
          ],
        ),
      ),
    );
  }
}
