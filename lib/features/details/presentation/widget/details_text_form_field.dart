import 'package:flutter/material.dart';
import 'package:risk_sample/core/screen_utils.dart';
import 'package:risk_sample/utils/constants.dart';



class DetailsTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final String validationMsg;
  final String? formFieldhint;
  final Widget? trailingIcons;
  final bool? textFormEnabled;

  const DetailsTextFormField({
    Key? key,
    required this.textEditingController,
    required this.label,
    required this.validationMsg,
    this.formFieldhint,
    this.trailingIcons,
    this.textFormEnabled
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.mQWidth * 0.05),
          child: const Divider(color: Colors.grey,),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: context.mQWidth * 0.05, vertical: context.mQWidth * 0.02,),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            
            SizedBox(width: context.mQWidth * 0.25,child: Text(label, style: TextStyles.boldText,)),
            SizedBox(width: context.mQWidth * 0.015,),
            Expanded(
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
            ),
            trailingIcons ?? const SizedBox(),
          ],),
        )
      ],);
  } 
  
}
