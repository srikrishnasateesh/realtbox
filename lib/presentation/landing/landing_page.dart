import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/usecase/get_property_list.dart';
import 'package:realtbox/domain/usecase/submit_enquiry.dart';
import 'package:realtbox/presentation/landing/bloc/landing_bloc.dart';
import 'package:realtbox/presentation/profile/bloc/profile_bloc.dart';
import 'package:realtbox/presentation/profile/profile_page.dart';
import 'package:realtbox/presentation/property/bloc/propert_list_bloc.dart';
import 'package:realtbox/presentation/property/property_list.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    LandingBloc landingBloc = BlocProvider.of<LandingBloc>(context);
    landingBloc.add(
      OnAppStarted(),
    );
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<LandingBloc, LandingState>(
          builder: (context, state) {
            switch (state) {
              case LandingHomeState():
                return BlocProvider(
                  create: (context) => PropertListBloc(
                    getIt<GetPropertyList>(),
                    getIt<SubmitEnquiry>(),
                  ),
                  child: PropertyList(),
                );

              case LandingProfileState():
                return BlocProvider(
                  create: (context) => ProfileBloc(),
                  child: const ProfilePage(),
                );

              default:
                return Container();
            }
          },
        ),
        bottomNavigationBar: SafeArea(
          child: BlocBuilder<LandingBloc, LandingState>(
            builder: (context, state) {
              return SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    border: Border.all(
                      color: Colors.amber,
                      width: 2.0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.white,
                      selectedItemColor: Colors.amber,
                      unselectedItemColor: Colors.grey,
                      currentIndex: landingBloc.currentIndex,
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                      elevation: 5,
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.business_rounded),
                            label: "Properties"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.person_2_rounded),
                            label: "Profile"),
                      ],
                      onTap: (index) =>
                          BlocProvider.of<LandingBloc>(context).add(
                        OnMenuChanged(pageIndex: index),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
