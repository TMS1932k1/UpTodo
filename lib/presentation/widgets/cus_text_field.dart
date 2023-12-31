import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimen_constant.dart';

class CusTextField extends StatelessWidget {
  const CusTextField({
    super.key,
    this.controller,
    this.keyboardType,
    this.hint,
    this.validator,
    required this.isObscure,
    this.onSaved,
    this.maxLength,
    this.text,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hint;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final bool isObscure;
  final int? maxLength;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),
        border: const OutlineInputBorder(),
        errorStyle:
            Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: kPaddingSmall,
        ),
      ),
      initialValue: text,
      validator: validator,
      obscureText: isObscure,
      onSaved: onSaved,
      maxLines: 1,
      maxLength: maxLength,
    );
  }
}
