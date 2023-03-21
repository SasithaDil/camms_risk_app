import 'package:flutter/material.dart';
import 'package:risk_sample/features/auth/presentation/login_screen.dart';
import 'package:risk_sample/features/auth/presentation/splash_screen.dart';
import 'package:risk_sample/features/details/presentation/details_screen.dart';
import 'package:risk_sample/features/details/presentation/image_preview.dart';
import 'package:risk_sample/features/details_dynamic/presentation/details_dynamic_screen.dart';

class ScreenRoutes {
  static const String toSplashScreen = 'toSplashScreen';
  static const String toLoginScreen = "toLoginScreen";
  static const String toDetailsScreen = "toDetailsScreen";
  static const String toImagePreviewScreen = "toImagePreviewScreen";
   static const String toInsidentdetailScreen = "toInsidentdetailScreen";
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
      case ScreenRoutes.toInsidentdetailScreen:
        return MaterialPageRoute(builder: (_) => const InsidentDetailScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}
