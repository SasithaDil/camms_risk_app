
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risk_sample/core/screen_utils.dart';
import 'package:risk_sample/core/theme.dart';
import 'package:risk_sample/utils/constants.dart';

class BottomModalTile extends StatelessWidget {
  const BottomModalTile({
    super.key,
    required this.context,
    required this.text,
    this.visibility = false,
    required this.onPressed,
  });

  final BuildContext context;
  final String text;
  final bool visibility;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: context.mQHeight * 0.07,
        width: double.infinity,
        color: lightGrey,
        child: Padding(
          padding: const EdgeInsets.only(
            top: UI.padding2x,
            left: UI.padding3x,
            right: UI.padding3x,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(text),
                    Visibility(
                      visible: visibility,
                      child: const Icon(
                        CupertinoIcons.check_mark,
                        color: Color.fromARGB(255, 45, 118, 234),
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: UI.padding2x,
                ),
                child: Divider(
                  color: grey,
                  height: 2.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}