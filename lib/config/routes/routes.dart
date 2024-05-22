import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/authentication/usecase/get_token.dart';
import 'package:realtbox/domain/authentication/usecase/login_otp_usecase.dart';
import 'package:realtbox/presentation/dummy_list.dart/bloc/data_bloc.dart';
import 'package:realtbox/presentation/dummy_list.dart/data_screen.dart';
import 'package:realtbox/presentation/dummy_list.dart/data_screen_new.dart';
import 'package:realtbox/presentation/home/bloc/home_bloc.dart';
import 'package:realtbox/presentation/home/home_page.dart';

import '../../presentation/authentication/login/bloc/login_bloc.dart';
import '../../presentation/authentication/login/login_screen.dart';
import '../../presentation/authentication/otp/bloc/otp_bloc.dart';
import '../../presentation/authentication/otp/otp_page.dart';
import '../../presentation/splash/bloc/splash_bloc.dart';
import '../../presentation/splash/splash_screen.dart';
import '../resources/constants/string_constants.dart';
import 'route_names.dart';

class AppRoute {
  static Route onGenerateRoutes(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        switch (settings.name) {
          case RouteNames.splash:
            return BlocProvider(
              create: (context) => SplashBloc(),
              child: const SplashScreen(),
            );
          case RouteNames.login:
            return BlocProvider(
                create: (context) => LoginBloc(getIt<GetLoginOtp>()),
                child: const LoginScreen());
          case RouteNames.otp:
            Map<String, dynamic> args =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => OtpBloc(
                getIt<GetLoginOtp>(),
                getIt<GetToken>(),
              ),
              child: OtpScreen(
                username: args["userName"],
                isExistingUser: args["isExistingUser"] as bool,
              ),
            );

          case RouteNames.home:
            return BlocProvider(
              create: (context) => HomeBloc(),
              child: const Home(),
            );
            case RouteNames.dummy:
            return BlocProvider(
              create: (context) => DataBloc(),
              child: DataScreenNew(),
            );

          default:
            return unDefinedRoute();
        }
      },
    );
  }

  static Scaffold unDefinedRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.noRouteFound),
      ),
      body: const Center(child: Text(StringConstants.noRouteFound)),
    );
  }

  static Route<dynamic> _materialBlocRoute(Widget view, BlocBase bloc) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
              create: (context) => bloc,
              child: view,
            ));
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(
      builder: (_) => view,
    );
  }
}
