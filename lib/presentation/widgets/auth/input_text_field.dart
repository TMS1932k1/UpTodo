import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimen_constant.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.title,
    this.hint,
    this.isObscure = false,
    required this.validator,
    this.controller,
    this.textInputType,
    this.onSaved,
  });

  final String title;
  final String? hint;
  final bool isObscure;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Container(
            margin: const EdgeInsets.only(top: kRadiusSmall),
            child: TextFormField(
              controller: controller,
              keyboardType: textInputType,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey),
                border: const OutlineInputBorder(),
                errorStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.red),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: kPaddingSmall,
                ),
              ),
              validator: validator,
              obscureText: isObscure,
              onSaved: onSaved,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
