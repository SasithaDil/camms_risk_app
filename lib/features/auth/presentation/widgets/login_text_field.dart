import 'package:flutter/material.dart';
import 'package:risk_sample/core/theme.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField(
      {Key? key,
      required this.textEditingController,
      required this.validationMsg,
      required this.labelText,
      required this.iconString,
      this.isPassword = false})
      : super(key: key);

  final TextEditingController textEditingController;
  final String validationMsg;
  final String labelText;
  final String iconString;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: TextFormField(
          controller: textEditingController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          obscureText: isPassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validationMsg;
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Organization",
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: Image.asset(iconString),
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: mainBlue),
            ),
          ),
        ),
      ),
    );
  }
}
