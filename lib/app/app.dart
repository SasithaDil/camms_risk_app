import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:risk_sample/core/theme.dart';
import 'package:risk_sample/features/details_dynamic/data/db_form_control.dart';
import 'package:risk_sample/features/details_dynamic/logic/bloc/incident_detail_bloc.dart';
import 'package:risk_sample/routes/routes.dart' as router;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IncidentDetailBloc>(
          create: (context) => IncidentDetailBloc(FormReadJson()),
        ),
      ],
      child: MaterialApp(
        title: 'Camms Risk Sample',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: kPrimaryColor,
        ),
        onGenerateRoute: router.Router.generateRoute,
        initialRoute: router.ScreenRoutes.toSplashScreen,
      ),
    );
  }
}
