import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/usecase/enquiry_list.dart';
import 'package:realtbox/domain/usecase/fcm-token.dart';
import 'package:realtbox/domain/usecase/get_property_details.dart';
import 'package:realtbox/domain/usecase/get_property_list.dart';
import 'package:realtbox/domain/usecase/get_refresh_token.dart';
import 'package:realtbox/domain/usecase/get_token.dart';
import 'package:realtbox/domain/usecase/get_user_self.dart';
import 'package:realtbox/domain/usecase/login_otp_usecase.dart';
import 'package:realtbox/domain/usecase/submit_enquiry.dart';
import 'package:realtbox/domain/usecase/toggle_favourite.dart';
import 'package:realtbox/domain/usecase/user_enquiry_list.dart';
import 'package:realtbox/domain/usecase/version-check.dart';
import 'package:realtbox/presentation/authentication/authentication.dart';
import 'package:realtbox/presentation/authentication/bloc/auth_bloc.dart';
import 'package:realtbox/presentation/details/project_details.dart';
import 'package:realtbox/presentation/enquiry_list/bloc/enquiry_list_bloc.dart';
import 'package:realtbox/presentation/enquiry_list/enquiry_list.dart';
import 'package:realtbox/presentation/home/bloc/home_bloc.dart';
import 'package:realtbox/presentation/home/home_page.dart';
import 'package:realtbox/presentation/landing/bloc/landing_bloc.dart';
import 'package:realtbox/presentation/landing/landing_page.dart';
import 'package:realtbox/presentation/property-filter/bloc/property_filetr_bloc.dart';
import 'package:realtbox/presentation/property-filter/property-filter-entity.dart';
import 'package:realtbox/presentation/property-filter/property-filters-screen.dart';
import 'package:realtbox/presentation/property/bloc/propert_list_bloc.dart';
import 'package:realtbox/presentation/property/property_list.dart';
import 'package:realtbox/presentation/property/property_list_type.dart';
import 'package:realtbox/presentation/property_details/bloc/propert_detail_bloc.dart';
import 'package:realtbox/presentation/property_details/property_details_screen.dart';
import 'package:realtbox/presentation/property_details/property_view.dart';
import 'package:realtbox/presentation/property_documents.dart/property_documents_screen.dart';
import 'package:realtbox/presentation/user_enquiry/bloc/user_enquiries_bloc.dart';
import 'package:realtbox/presentation/user_enquiry/user_enquiries_page.dart';

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
              create: (context) => SplashBloc(
                getIt<GetUserSelf>(),
                getIt<CheckVersion>(),
                getIt<GetFcmToken>(),
                getIt<GetRefreshToken>(),
              ),
              child: const SplashScreen(),
            );
          case RouteNames.authentication:
            return BlocProvider(
              create: (context) => AuthBloc(getIt<GetLoginOtp>()),
              child: const Authentication(),
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
                getIt<GetUserSelf>(),
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
          case RouteNames.landing:
            return BlocProvider(
              create: (context) => LandingBloc(),
              child: const LandingPage(),
            );
          case RouteNames.propertyList:
            return BlocProvider(
              create: (context) => PropertListBloc(
                getIt<GetPropertyList>(),
                getIt<SubmitEnquiry>(),
                getIt<ToggleFavourite>(),
                PropertyListType.normal
              ),
              child: PropertyList(),
            );
          case RouteNames.propertyDetails:
           debugPrint("args: ${settings.arguments}");
          Map<String, dynamic> args =
                settings.arguments as Map<String, dynamic>;
            debugPrint("args: $args");
            String id = args["id"];
            debugPrint("id: $id");
            return ProjectDetailsPage(
              propertyId: id,
              getPropertyDetails: getIt<GetPropertyDetails>(),
            );
          /* PropertyView(
                property: (settings.arguments as Property),
              ), */

          case RouteNames.propertyDocs:
            Map<String, dynamic> args =
                settings.arguments as Map<String, dynamic>;
            final imageList = args['images'] as List<String>;
            final isNetworkUrls = args['network_images'];
            return PropertyDocumentsScreen(
                imageList: imageList, isNetworkUrls: isNetworkUrls);
          case RouteNames.enquiryList:
            Map<String, dynamic> args =
                settings.arguments as Map<String, dynamic>;
            String propId = args["propId"];
            String propName = args["propName"];
            return BlocProvider(
              create: (context) => EnquiryListBloc(getIt<GetEnquiryList>()),
              child: EnquiryList(
                propertyId: propId,
                propertyName: propName,
              ),
            );
          case RouteNames.userEnquiryList:
            return BlocProvider(
              create: (context) =>
                  UserEnquiriesBloc(getIt<GetUserEnquiryList>()),
              child: const UserEnquiryList(),
            );
          case RouteNames.propertyfilters:
            final filter = settings.arguments as PropertyFilter;
            return BlocProvider(
              create: (context) => PropertyFilterBloc(),
              child: PropertyFiltersScreen(propertyFilter: filter),
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
