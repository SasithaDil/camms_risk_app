import 'dart:async';

import 'package:flutter/material.dart';
import 'package:risk_sample/core/screen_utils.dart';
import 'package:risk_sample/routes/routes.dart';
import 'package:risk_sample/routes/routes_extension.dart';
import 'package:risk_sample/utils/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2),
        () => context.toNamed(ScreenRoutes.toLoginScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: context.mQHeight * 0.4,
          width: context.mQWidth * 0.4,
          child: Image.asset(logo),
        ),
      ),
    );
  }
}
