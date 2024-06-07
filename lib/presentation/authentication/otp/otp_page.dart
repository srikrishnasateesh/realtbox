import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/assests_manager.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/config/resources/style_manager.dart';
import 'package:realtbox/config/resources/value_manager.dart';
import 'package:realtbox/presentation/authentication/otp/bloc/otp_bloc.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';
import 'package:realtbox/presentation/widgets/basic_text_field.dart';
import 'package:flutter/material.dart';
import 'package:realtbox/presentation/widgets/progress_indicator.dart';

class OtpScreen extends StatelessWidget {
  final String username;
  final bool isExistingUser;

  OtpScreen({
    super.key,
    required this.username,
    required this.isExistingUser,
  });

  final otpController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final otpBloc = BlocProvider.of<OtpBloc>(context);
    otpBloc.add(OnOtpInit(username, isExistingUser));
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
      child: Scaffold(
        body: SafeArea(
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
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: AppSize.s150,
                              child: Image.asset(
                                profileLogo,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppPadding.p0, top: AppPadding.p25),
                              child: BasicText(
                                text: StringConstants.otpTitle,
                                textStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppPadding.p2, top: AppPadding.p8),
                              child: BasicText(
                                text: StringConstants.codeVerification,
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            BasicText(
                              text: "${StringConstants.phoneCode} $username",
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppPadding.p8, top: AppPadding.p12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BlocBuilder<OtpBloc, OtpState>(
                                    builder: (context, state) {
                                      if (state is OtpShowProfileFields ||
                                          !isExistingUser) {
                                        return Column(
                                          children: [
                                            BasicTextField(
                                              hintText:
                                                  StringConstants.fullName,
                                              controller: nameController,
                                              keyboardType: TextInputType.name,
                                              style: getSemiBoldStyle(
                                                  fontSize: FontSize.s16,
                                                  color:
                                                      ColorManager.textColor),
                                              maxLength: 30,
                                              onChanged: (val) {},
                                            ),
                                            const SizedBox(
                                              height: AppMargin.m12,
                                            ),
                                            BasicTextField(
                                              hintText: StringConstants.email,
                                              controller: emailController,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              style: getSemiBoldStyle(
                                                  fontSize: FontSize.s16,
                                                  color:
                                                      ColorManager.textColor),
                                              maxLength: 30,
                                              onChanged: (val) {},
                                            ),
                                            const SizedBox(
                                              height: AppMargin.m12,
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                  BasicTextField(
                                    hintText: StringConstants.otp,
                                    controller: otpController,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    formatter: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    obscureText: true,
                                    style: getSemiBoldStyle(
                                        fontSize: FontSize.s16,
                                        color: ColorManager.textColor),
                                    maxLength: 6,
                                    onChanged: (val) {},
                                  ),
                                ],
                              ),
                            ),
                            BlocBuilder<OtpBloc, OtpState>(
                              builder: (context, state) {
                                if (state is OtpError) {
                                  return Text(state.message,
                                      style:
                                          const TextStyle(color: Colors.red));
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            BlocBuilder<OtpBloc, OtpState>(
                              builder: (context, state) {
                                if (state is OtpResent) {
                                  return const Text("Otp Send Successfully",
                                      style: TextStyle(color: Colors.green));
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppPadding.p0, top: AppPadding.p8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(StringConstants.resendMsg,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      textAlign: TextAlign.center),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: AppPadding.p8),
                                    child: InkWell(
                                      onTap: () {
                                        otpBloc.add(OnResnedOtp());
                                      },
                                      child: Text(StringConstants.resend,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontStyle: FontStyle.italic,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: Colors.black,
                                                decorationThickness: 2.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppPadding.p0,
                                top: AppPadding.p8,
                              ),
                              child: ElevatedButton(
                                  onPressed: () {
                                    otpBloc.add(
                                      OnOtpSubmit(
                                        name: nameController.text,
                                        otp: otpController.text,
                                        email: emailController.text,
                                      ),
                                    );
                                  },
                                  child: const Text(StringConstants.submit)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              BlocBuilder<OtpBloc, OtpState>(
                builder: (context, state) {
                  if (state is OtpInProgress) {
                    return const ProgressLoader();
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
