import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/presentation/profile/bloc/profile_bloc.dart';
import 'package:realtbox/presentation/widgets/avatar_widget.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';
import 'package:realtbox/presentation/widgets/key_value_column.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(OnProfileInit());
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ShowLogoutConfirmation) {
              showLogoutConfirmationDialog(context, () {
                BlocProvider.of<ProfileBloc>(context).add(OnLogoutConfirmed());
              });
            }
            if (state is ProfileNavigation) {
              Navigator.pushNamedAndRemoveUntil(
                  context, state.route, (route) => true);
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(24),
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileDataLoaded) {
                      return Column(
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
                         
                          KeyValueColumn(
                              displayKey: "Mobile", displayValue: state.mobile),
                          KeyValueColumn(
                              displayKey: "Email", displayValue: state.email),
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
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                                onPressed: () {
                                  showLogoutConfirmationDialog(context, () {
                                    BlocProvider.of<ProfileBloc>(context)
                                        .add(OnLogoutConfirmed());
                                  });
                                },
                                child: const Text("Log out")),
                          )
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ),
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


/* 
listener: (context, state) {
                  if (state is ShowLogoutConfirmation) {
                    showLogoutConfirmationDialog(context, () {
                      BlocProvider.of<ProfileBloc>(context)
                          .add(OnLogoutConfirmed());
                    });
                  }
                },
 */