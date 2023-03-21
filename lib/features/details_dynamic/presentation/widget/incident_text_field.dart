import 'package:flutter/material.dart';
import 'package:risk_sample/core/screen_utils.dart';

class InsidentTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String validationMsg;
  final String? formFieldhint;
  final Widget? trailingIcons;
  final bool? textFormEnabled;

  const InsidentTextFormField(
      {Key? key,
      required this.textEditingController,
      required this.validationMsg,
      this.formFieldhint,
      this.trailingIcons,
      this.textFormEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mQWidth * 0.01),
      child: TextFormField(
        controller: textEditingController,
        minLines: 1,
        maxLines: 2,
        enabled: textFormEnabled ?? true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMsg;
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: formFieldhint ?? '',
        ),
      ),
    );
  }
}
