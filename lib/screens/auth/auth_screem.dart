import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/widgets/auth/bottom_option.dart';
import 'package:todo_app/widgets/auth/input_text_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
    this.isLogin = true,
  });

  final bool isLogin;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late bool _isLogin;
  final duration = const Duration(milliseconds: 300);

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _isLogin = widget.isLogin;
    _animationController = AnimationController(
      vsync: this,
      duration: duration,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Change [_isLogin] mode
  void _changeMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
  }

  /// Check available [email]
  /// If [email] != null and [email] is not empty and [email] is valid email
  /// Will return null
  /// Else return invalid message
  String? _validatorEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email.';
    }

    final isValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);

    if (!isValid) {
      return 'Email is invalid.';
    }

    return null;
  }

  /// Check available [password]
  /// If [password] != null and [password] is not empty and [password] is valid password
  /// Will return null
  /// Else return invalid message
  String? _validatorPassword(String? password) {
    if (password == null || password!.isEmpty || password.length < 6) {
      return 'Please enter your password.';
    }
    return null;
  }

  /// Check available [confirmPassword]
  /// If [confirmPassword] != null and [confirmPassword] is not empty and [confirmPassword] is matched with password
  /// Will return null
  /// Else return invalid message
  String? _validatorConfirmPassword(String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password.';
    }

    if (confirmPassword != _passwordController.text) {
      return 'Not matched with password.';
    }

    return null;
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
            const SizedBox(height: kPaddingSmall),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            InputTextField(
                              title: 'Email',
                              hint: 'Enter your Email',
                              validator: _validatorEmail,
                              textInputType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: kPaddingSmall),
                            InputTextField(
                              title: 'Password',
                              hint: 'Enter your Password',
                              isObscure: true,
                              validator: _validatorPassword,
                              controller: _passwordController,
                              textInputType: TextInputType.visiblePassword,
                            ),
                            const SizedBox(height: kPaddingSmall),
                            AnimatedContainer(
                              curve: Curves.easeIn,
                              duration: duration,
                              constraints: BoxConstraints(
                                maxHeight: !_isLogin ? 100 : 0,
                                minHeight: !_isLogin ? 100 : 0,
                              ),
                              child: SingleChildScrollView(
                                child: InputTextField(
                                  title: 'Confirm Password',
                                  hint: 'Confirm your Password',
                                  isObscure: true,
                                  validator: _validatorConfirmPassword,
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: kPaddingLarge),
                      SizedBox(
                        width: 327,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: Theme.of(context).elevatedButtonTheme.style,
                          child: Text(
                            _isLogin ? 'Login' : 'Register',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: kPaddingSmall),
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
