import 'package:flutter/material.dart';
import 'package:risk_sample/core/theme.dart';
import 'package:risk_sample/routes/routes.dart' as router;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camms Risk Sample',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
      ),
      onGenerateRoute: router.Router.generateRoute,
      initialRoute: router.ScreenRoutes.toSplashScreen,
    );
  }
}
