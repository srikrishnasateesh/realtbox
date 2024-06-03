import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/usecase/get_property_list.dart';
import 'package:realtbox/domain/usecase/get_token.dart';
import 'package:realtbox/domain/usecase/login_otp_usecase.dart';
import 'package:realtbox/presentation/home/bloc/home_bloc.dart';
import 'package:realtbox/presentation/home/home_page.dart';
import 'package:realtbox/presentation/property/bloc/propert_list_bloc.dart';
import 'package:realtbox/presentation/property/property_list.dart';
import 'package:realtbox/presentation/property_details/bloc/propert_detail_bloc.dart';
import 'package:realtbox/presentation/property_details/property_details_screen.dart';
import 'package:realtbox/presentation/property_documents.dart/property_documents_screen.dart';

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
          case RouteNames.propertyList:
            return BlocProvider(
              create: (context) => PropertListBloc(
                getIt<GetPropertyList>(),
              ),
              child: PropertyList(),
            );
          case RouteNames.propertyDetails:
            return BlocProvider(
              create: (context) => PropertDetailBloc(),
              child: PropertyDetailsScreen(
                property: (settings.arguments as Property),
              ),
            );

            case RouteNames.propertyDocs:
            Map<String, dynamic> args =
                settings.arguments as Map<String, dynamic>;
                final imageList = args['images'] as List<String>;
                final isNetworkUrls = args['network_images'];
            return PropertyDocumentsScreen(imageList: imageList, isNetworkUrls: isNetworkUrls);

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
