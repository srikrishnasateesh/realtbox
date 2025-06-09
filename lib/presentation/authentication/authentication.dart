import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/usecase/get_token.dart';
import 'package:realtbox/domain/usecase/get_user_self.dart';
import 'package:realtbox/domain/usecase/login_otp_usecase.dart';
import 'package:realtbox/presentation/authentication/bloc/auth_bloc.dart';
import 'package:realtbox/presentation/authentication/login/bloc/login_bloc.dart';
import 'package:realtbox/presentation/authentication/otp/bloc/otp_bloc.dart';
import 'package:realtbox/presentation/authentication/register_screen.dart';
import 'package:realtbox/presentation/authentication/sign_in_screen.dart';
import 'package:realtbox/presentation/widgets/auth_stack_image.dart';
import 'package:realtbox/presentation/widgets/app_logo.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';
import 'package:realtbox/presentation/widgets/circular_progress_bar.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    authBloc.add(AppStarted());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthStackImage(),
             Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 30.0, top: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: Platform.isIOS
                        ? const EdgeInsets.only(right: 220)
                        : const EdgeInsets.only(right: 220),
                    child: const AppLogo(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: BasicText(
                      text: 'Sign in',
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Stack(
              children: [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    switch (state) {
                      case AuthLoginState():
                        return BlocProvider(
                          create: (context) => LoginBloc(getIt<GetLoginOtp>()),
                          child: const SignInScreen(),
                        );
                      case AuthRegisterState():
                        return BlocProvider(
                          create: (context) => OtpBloc(
                            getIt<GetLoginOtp>(),
                            getIt<GetToken>(),
                            getIt<GetUserSelf>(),
                          ),
                          child: RegisterScreen(
                            username: state.mobile,
                            isExistingUser: state.isExistingUser,
                          ),
                        );
                      default:
                        return Container();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
