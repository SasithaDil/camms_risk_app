import 'package:flutter/material.dart';
import 'package:risk_sample/core/theme.dart';
import 'package:risk_sample/utils/constants.dart';

class ComboButtons extends StatelessWidget {
  const ComboButtons({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.buttonText,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: UI.padding4x * 1.5,
        width: UI.padding8x * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: buttonColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: white,
            ),
            const SizedBox(
              width: UI.padding,
            ),
            DefaultTextStyle(
              style: const TextStyle(color: white, fontSize: 18.0),
              child: Text(
                buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
