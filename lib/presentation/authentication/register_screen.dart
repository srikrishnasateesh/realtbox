import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/presentation/authentication/bloc/auth_bloc.dart';
import 'package:realtbox/presentation/authentication/otp/bloc/otp_bloc.dart';
import 'package:realtbox/presentation/widgets/circular_progress_bar.dart';
import 'package:realtbox/presentation/widgets/email_input_field.dart';
import 'package:realtbox/presentation/widgets/mobile_input_field.dart';
import 'package:realtbox/presentation/widgets/name_input_field%20copy.dart';
import 'package:realtbox/presentation/widgets/password_input_field.dart';
import 'package:realtbox/presentation/widgets/primary_button.dart';

class RegisterScreen extends StatelessWidget {
  final String username;
  final bool isExistingUser;
  const RegisterScreen(
      {super.key, required this.username, required this.isExistingUser});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final registerBloc = BlocProvider.of<OtpBloc>(context);

    authBloc.add(RegisterInit());
    registerBloc.add(OnOtpInit(username, isExistingUser));

    TextEditingController emailInputController = TextEditingController();
    TextEditingController nameInputController = TextEditingController();
    TextEditingController otpInputController = TextEditingController();

    return BlocListener<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is OtpNavigate) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            state.route,
            (route) => false,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Stack(
          children: [
            Column(
              children: [
                const Text(
                  StringConstants.registerText,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, left: 10),
                  child: Column(
                    children: [
                      BlocBuilder<OtpBloc, OtpState>(
                        builder: (context, state) {
                          if (state is OtpShowProfileFields ||
                              !isExistingUser) {
                            return Column(
                              children: [
                                EmailInputField(
                                    textEditingController:
                                        emailInputController),
                                const SizedBox(
                                  height: 20,
                                ),
                                NameInputField(
                                    textEditingController: nameInputController),
                                const SizedBox(
                                  height: 20,
                                ),
                                
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                      PasswordInputField(
                                    textEditingController: otpInputController),
                      BlocBuilder<OtpBloc, OtpState>(
                        builder: (context, state) {
                          if (state is OtpError) {
                            return Text(state.message,
                                style: const TextStyle(color: Colors.red));
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: PrimaryButton(
                    buttonText: "Register",
                    onPressed: () {
                      debugPrint("Email: ${emailInputController.text}");
                      debugPrint("Name: ${nameInputController.text}");
                      debugPrint("Otp: ${otpInputController.text}");
                      registerBloc.add(OnOtpSubmit(
                        otp: otpInputController.text,
                        email: emailInputController.text,
                        name: nameInputController.text,
                      ));
                    },
                  ),
                )
              ],
            ),
            BlocBuilder<OtpBloc, OtpState>(
              builder: (context, state) {
                if (state is OtpInProgress) {
                  return CircularProgressBar();
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
