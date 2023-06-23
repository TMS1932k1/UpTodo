import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/cubits/auth/auth_loading_cubit.dart';
import 'package:todo_app/business_logic/cubits/auth/auth_loading_state.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/presentation/widgets/auth/bottom_option.dart';
import 'package:todo_app/presentation/widgets/auth/title_text_field.dart';
import 'package:todo_app/data/repositories/auth_firebase.dart';

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
  final _duration = const Duration(milliseconds: 300);
  Map<String, String> _auth = {
    'email': '',
    'password': '',
  };

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _isLogin = widget.isLogin;
    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
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

  /// Check validator of inform input by [_formKey.currentState]
  /// If it's valid to register or login
  void _submit() async {
    final String? error;
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    // Hide keyboard
    FocusScope.of(context).unfocus();

    // Set state to start loading
    BlocProvider.of<AuthLoadingCubit>(context).startLoading();

    if (_isLogin) {
      error = await signInWithEmailAndPassword(_auth);
    } else {
      error = await createUserByEmailPassword(_auth);
    }
    if (error != null) {
      _showSnackBarError(error);
    }

    if (mounted) {
      // Set state to stop loading
      BlocProvider.of<AuthLoadingCubit>(context).stopLoading();
    }
  }

  void _showSnackBarError(String mes) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mes),
        duration: const Duration(milliseconds: 2000),
        backgroundColor: Colors.red,
      ),
    );
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
    if (password == null || password.isEmpty || password.length < 6) {
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
      resizeToAvoidBottomInset: false,
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
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TitleTextField(
                                title: 'Email',
                                hint: 'Enter your Email',
                                validator: _validatorEmail,
                                textInputType: TextInputType.emailAddress,
                                onSaved: (email) => _auth['email'] = email!,
                              ),
                              const SizedBox(height: kPaddingSmall),
                              TitleTextField(
                                title: 'Password',
                                hint: 'Enter your Password',
                                isObscure: true,
                                validator: _validatorPassword,
                                controller: _passwordController,
                                textInputType: TextInputType.visiblePassword,
                                onSaved: (password) =>
                                    _auth['password'] = password!,
                              ),
                              const SizedBox(height: kPaddingSmall),
                              AnimatedContainer(
                                curve: Curves.easeIn,
                                duration: _duration,
                                constraints: BoxConstraints(
                                  maxHeight: !_isLogin ? 100 : 0,
                                  minHeight: !_isLogin ? 100 : 0,
                                ),
                                child: SingleChildScrollView(
                                  child: TitleTextField(
                                    title: 'Confirm Password',
                                    hint: 'Confirm your Password',
                                    isObscure: true,
                                    validator: !_isLogin
                                        ? _validatorConfirmPassword
                                        : (_) => null,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: kPaddingLarge),
                        BlocBuilder<AuthLoadingCubit, AuthLoadingState>(
                          builder: (context, state) {
                            if (state.isLoading) {
                              return const CircularProgressIndicator();
                            }

                            return SizedBox(
                              width: 327,
                              child: ElevatedButton(
                                onPressed: _submit,
                                style:
                                    Theme.of(context).elevatedButtonTheme.style,
                                child: Text(
                                  _isLogin ? 'Login' : 'Register',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
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
