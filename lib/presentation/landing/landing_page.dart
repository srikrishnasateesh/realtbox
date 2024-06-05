import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/usecase/get_property_list.dart';
import 'package:realtbox/presentation/home/bloc/home_bloc.dart';
import 'package:realtbox/presentation/home/home_page.dart';
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
    return Scaffold(
      body: BlocBuilder<LandingBloc, LandingState>(
        builder: (context, state) {
          switch (state) {
            case LandingHomeState():
              return BlocProvider(
                create: (context) => PropertListBloc(getIt<GetPropertyList>()),
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
      bottomNavigationBar: BlocBuilder<LandingBloc, LandingState>(
        builder: (context, state) {
          return BottomNavigationBar(
              selectedItemColor: Colors.amber,
              unselectedItemColor: Colors.grey,
              currentIndex: landingBloc.currentIndex,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.business_rounded), label: "Properties"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_2_rounded), label: "Profile"),
              ],
              onTap: (index) => BlocProvider.of<LandingBloc>(context).add(
                OnMenuChanged(pageIndex: index),
              ),
            );
        },
      ),
    );
  }
}
