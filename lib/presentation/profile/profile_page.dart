import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/core/utils/dialog_utils.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/usecase/delete_account.dart';
import 'package:realtbox/presentation/delete_account/bloc/delete_account_bloc.dart';
import 'package:realtbox/presentation/delete_account/delete_account_bottomsheet.dart';
import 'package:realtbox/presentation/profile/bloc/profile_bloc.dart';
import 'package:realtbox/presentation/widgets/avatar_widget.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';
import 'package:realtbox/presentation/widgets/key_value_column.dart';
import 'package:realtbox/presentation/widgets/profile_menu_widget.dart';

class ProfilePage extends StatelessWidget {
  bool isAdmin = false;
   ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String enroll = LocalStorage.getString(StringConstants.enrollmentType);
    isAdmin = enroll == StringConstants.enrollmentTypeAdmin;
    debugPrint("Is Admin: $isAdmin");
    BlocProvider.of<ProfileBloc>(context).add(OnProfileInit());
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) async {
            if (state is ShowLogoutConfirmation) {
              showLogoutConfirmationDialog(context, () {
                BlocProvider.of<ProfileBloc>(context).add(OnLogoutConfirmed());
              });
            }
            if (state is ProfileNavigation) {
              if (state.removePage) {
                Navigator.pushNamedAndRemoveUntil(
                    context, state.route, (route) => false);
              } else {
                await  Navigator.pushNamed(context, state.route);
                BlocProvider.of<ProfileBloc>(context).add(OnProfileInit());
              }
            }
          },
          child: SafeArea(
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ShowLoginMessage) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      //  mainAxisSize: MainAxisSize.max,
                        children: [
                          const BasicText(
                            text: StringConstants.loginMessage,
                            textStyle: TextStyle(
                              color: kSecondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<ProfileBloc>(context)
                                      .add(OnLoginClicked());
                                },
                                child: const Text("Login")),
                          )
                        ],
                      ),
                    ),
                  );
                }
                if (state is ProfileDataLoaded) {
                  return SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AvatarWidget(
                            imageUrl: state.userImageUrl,
                            name: state.userName,
                            radius: 90,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          BasicText(
                            text: state.userName,
                            textStyle:
                                Theme.of(context).textTheme.headlineLarge,
                          ),
                          BasicText(
                            text: state.email,
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          BasicText(
                            text: state.mobile,
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(color: kOutlineColor, height: 1.0),
                          const SizedBox(
                            height: 5,
                          ),
                          ProfileMenuWidget(
                              title: !isAdmin? "My Enquiries" : "All Enquiries",
                              icon: Icons.list,
                              onPress: () {
                                BlocProvider.of<ProfileBloc>(context)
                                    .add(OnMyEnquiriesClicked());
                              }),
                          ProfileMenuWidget(
                              title: "Log out",
                              icon: Icons.logout,
                              onPress: () {
                                showLogoutConfirmationDialog(context, () {
                                  BlocProvider.of<ProfileBloc>(context)
                                      .add(OnLogoutConfirmed());
                                });
                              }),
                          ProfileMenuWidget(
                              title: "Delete Account",
                              textColor: Colors.red,
                              icon: Icons.delete,
                              onPress: () {
                                showConfirmationDialog(context,
                                    title: "Confirm!",
                                    content:
                                        StringConstants.deleteConfirmMessage,
                                    showSecondaryAction: true, onConfirmed: () {
                                  showBottomSheet(context);
                                }, onCancelled: () {}, confirmButtonText: "Ok");
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: false,
                            child: SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Edit profile")),
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                  onPressed: () {
                                    showLogoutConfirmationDialog(context, () {
                                      BlocProvider.of<ProfileBloc>(context)
                                          .add(OnLogoutConfirmed());
                                    });
                                  },
                                  child: const Text("Log out")),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ));
  }

  void showBottomSheet(
    BuildContext context,
  ) async {
    final result = await showModalBottomSheet<Map<String, String>>(
        context: context,
        builder: (context) => BlocProvider(
              create: (context) => DeleteAccountBloc(getIt<DeleteAccount>()),
              child: const DeleteAccountBottomsheet(),
            ));
  }

  void showLogoutConfirmationDialog(
      BuildContext context, VoidCallback onSubmit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                onSubmit();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
