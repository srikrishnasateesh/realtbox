import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/routes/routes.dart';
import 'package:realtbox/config/theme/app_theme.dart';
import 'package:realtbox/core/listeners/cubit/internet_cubit.dart';
import 'package:realtbox/presentation/connectivity_status.dart';
import 'config/routes/route_names.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetCubit(),
      child: ConnectivityStatus(
        child: MaterialApp(
          title: "RealtBox",
          debugShowCheckedModeBanner: false,
          initialRoute: RouteNames.splash,
          onGenerateRoute: AppRoute.onGenerateRoutes,
          theme: theme(),
        ),
      ),
    );
  }
}
