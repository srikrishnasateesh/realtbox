import 'package:flutter/services.dart';
import 'package:realtbox/config/resources/assests_manager.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/resources/value_manager.dart';
import 'package:realtbox/presentation/authentication/login/bloc/login_bloc.dart';
import 'package:realtbox/presentation/widgets/basic_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/presentation/widgets/progress_indicator.dart';

import '../../../config/resources/font_manager.dart';
import '../../../config/resources/style_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginNavigate) {
          Navigator.pushNamed(context, state.route,
              arguments: state.arguments);
        }
      },
      child: Stack(
        children: [
          Container(
            color: ColorManager.backGround,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p30,
                vertical: AppPadding.p20,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s65,
                      child: Image.asset(
                        appLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppPadding.p0,
                        top: AppPadding.p25,
                      ),
                      child: Text(
                        StringConstants.loginTitle,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppPadding.p20, top: AppPadding.p8),
                      child: Text(
                        StringConstants.loginSubTitle,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    BasicTextField(
                      controller: phoneNumberController,
                      keyboardType: const TextInputType.numberWithOptions(signed: true,decimal: true),
                      formatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                      hintText: StringConstants.mobileNumber,
                      maxLength: 10,
                      style: getSemiBoldStyle(
                          fontSize: FontSize.s16,
                          color: ColorManager.textColor),
                      onChanged: (val) {
                        //debugPrint("on changed: $val");
                      },
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginError) {
                          return Text(
                            state.errorMessage,
                            style: const TextStyle(color: Colors.red),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppPadding.p0,
                        top: AppPadding.p20,
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context).add(
                              OnLoginOtpRequested(phoneNumberController.text),
                            );
                          },
                          child: const Text(
                            StringConstants.requestOtp,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginProgress) {
                return const ProgressLoader();
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
