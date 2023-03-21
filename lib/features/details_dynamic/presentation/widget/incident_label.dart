import 'package:flutter/material.dart';
import 'package:risk_sample/core/screen_utils.dart';
import 'package:risk_sample/utils/constants.dart';


class InsidentLabel extends StatelessWidget {
  final String label;

  const InsidentLabel({
    Key? key,
    required this.label
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return 
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: 
            
            SizedBox(width: context.mQWidth * 0.25,child: Text(label, style: TextStyles.boldText,)),
          
        );
  } 
  
}
