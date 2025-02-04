import 'dart:io';

import 'package:realtbox/config/resources/assests_manager.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/resources/value_manager.dart';
import 'package:realtbox/core/utils/launch_url.dart';
import 'package:realtbox/presentation/dialogs/custom_alert.dart';
import 'package:realtbox/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final SplashBloc bloc = BlocProvider.of<SplashBloc>(context);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    BlocProvider.of<SplashBloc>(context).add(OnSplashScrennShown());
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigate) {
          Navigator.pushReplacementNamed(context, state.route);
        }
        if (state is ShowVersionUpdate) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomAlert(
                    title: state.title,
                    message: state.message,
                    primaryActionLabel: update,
                    secondaryActionLabel: state.showSkip ? skip : null,
                    onPrimaryAction: () async {
                      debugPrint("On update clicked");
                      final url = Platform.isAndroid
                          ? "https://market://details?id=$packageName"
                          : "https://apps.apple.com/app/id$packageName";

                      await launchCustomUrl(url);
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    onSecondaryAction: () {
                      debugPrint("On skip clicked");
                      bloc.add(OnSkipVersion());
                    });
              });
        }
      },
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        body: SafeArea(
          child: 
       
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(splashBg),
                fit: BoxFit.cover
              ),
              
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: kPrimaryColor),
                  ),
                  const SizedBox(height: AppMargin.m18),
                  const CircularProgressIndicator.adaptive(
                    backgroundColor: kPrimaryColor,
                    valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
                  ),
                ],
              ),
            ),
          ),
       
       /*  Container(
  width: double.infinity,
  height: double.infinity,
  child: Image.asset(
    splashBg,
    fit: BoxFit.cover,
  ),
) */
       
        ),
      ),
    );
  }
}
