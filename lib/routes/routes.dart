import 'package:flutter/material.dart';
import 'package:risk_sample/features/auth/presentation/login_screen.dart';
import 'package:risk_sample/features/auth/presentation/splash_screen.dart';
import 'package:risk_sample/features/details/presentation/details_screen.dart';
import 'package:risk_sample/features/details/presentation/image_preview.dart';

class ScreenRoutes {
  static const String toSplashScreen = 'toSplashScreen';
  static const String toLoginScreen = "toLoginScreen";
  static const String toDetailsScreen = "toDetailsScreen";
  static const String toImagePreviewScreen = "toImagePreviewScreen";
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // var args = settings.arguments;
    switch (settings.name) {
      case ScreenRoutes.toSplashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case ScreenRoutes.toLoginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case ScreenRoutes.toDetailsScreen:
        return MaterialPageRoute(builder: (_) => const DetailsScreen());
      case ScreenRoutes.toImagePreviewScreen:
        var data = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ImagePreviewScreen(imageUrl: data.toString()));
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}
