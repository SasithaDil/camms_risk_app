import 'dart:io';

import 'package:flutter/material.dart';
import 'package:risk_sample/core/screen_utils.dart';


class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: context.mQHeight * 0.45,
          width: context.mQHeight * 0.45,
          child: Image.file(
            File(widget.imageUrl),
          ),
        ),
      ),
    );
  }
}
