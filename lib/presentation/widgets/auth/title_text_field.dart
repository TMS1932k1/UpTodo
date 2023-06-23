import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/presentation/widgets/cus_text_field.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({
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
            child: CusTextField(
              controller: controller,
              keyboardType: textInputType,
              isObscure: isObscure,
              hint: hint,
              onSaved: onSaved,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}
