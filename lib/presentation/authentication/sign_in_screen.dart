import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/presentation/authentication/bloc/auth_bloc.dart';
import 'package:realtbox/presentation/authentication/login/bloc/login_bloc.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';
import 'package:realtbox/presentation/widgets/circular_progress_bar.dart';
import 'package:realtbox/presentation/widgets/mobile_input_field.dart';
import 'package:realtbox/presentation/widgets/primary_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    authBloc.add(LoginInit());

    TextEditingController mobileInputController = TextEditingController();
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Map<String, dynamic> args = state.arguments as Map<String, dynamic>;
          authBloc.add(
            OnLoginSuccess(
                mobile: args["userName"],
                isExistingUser: args["isExistingUser"] as bool),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Stack(
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: BasicText(
                      text: StringConstants.registerText,
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeightManager.regular,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, left: 10),
                  child: MobileInputField(
                    textEditingController: mobileInputController,
                    onInputChanged: (value) {
                      loginBloc.add(OnMobileInputChanged());
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    debugPrint("State: $state");
                    if (state is LoginError) {
                      return Column(
                        children: [
                          Text(
                            state.errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: PrimaryButton(
                    buttonText: "Continue",
                    onPressed: () {
                      debugPrint("Mobile: ${mobileInputController.text}");
                      loginBloc
                          .add(OnLoginOtpRequested(mobileInputController.text));
                    },
                  ),
                ),
              ],
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginProgress) {
                  return CircularProgressBar();
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
