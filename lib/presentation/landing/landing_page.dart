import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/assests_manager.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/usecase/birdview.dart';
import 'package:realtbox/domain/usecase/get_property_list.dart';
import 'package:realtbox/domain/usecase/submit_enquiry.dart';
import 'package:realtbox/domain/usecase/toggle_favourite.dart';
import 'package:realtbox/presentation/bird_view/bird_view_screen.dart';
import 'package:realtbox/presentation/landing/bloc/landing_bloc.dart';
import 'package:realtbox/presentation/landing/bottom_bar_items.dart';
import 'package:realtbox/presentation/profile/bloc/profile_bloc.dart';
import 'package:realtbox/presentation/profile/profile_page.dart';
import 'package:realtbox/presentation/property/bloc/propert_list_bloc.dart';
import 'package:realtbox/presentation/property/property_list.dart';
import 'package:realtbox/presentation/property/property_list_type.dart';
import 'package:realtbox/presentation/saved/bloc/saved_bloc.dart';
import 'package:realtbox/presentation/saved/saved_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Handle foreground notifications to show any custom dialogs or any other UI
    //  Un comment if required
    /* FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        // Show a dialog from stateless widget when notification is received
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(message.notification?.title ?? 'Notification'),
              content:
                  Text(message.notification?.body ?? 'You have a new message.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }); */

    String enroll = LocalStorage.getString(StringConstants.enrollmentType);
    LandingBloc landingBloc = BlocProvider.of<LandingBloc>(context);
    landingBloc.add(
      OnAppStarted(),
    );

    var enabledItems = [BottomBarItems.propertyList, BottomBarItems.mapView];
    if (enroll != StringConstants.enrollmentTypeAdmin) {
      enabledItems.add(BottomBarItems.saved);
    }
    enabledItems.add(BottomBarItems.profile);

    return SafeArea(
      child: BlocBuilder<LandingBloc, LandingState>(
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) {
                return;
              }
              if (landingBloc.currentIndex != 0) {
                BlocProvider.of<LandingBloc>(context).add(
                  OnMenuChanged(
                    pageIndex: 0,
                    item: enabledItems[0],
                  ),
                );
              } else {
                SystemNavigator.pop();
              }
            },
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
                          getIt<ToggleFavourite>(),
                          PropertyListType.normal,
                        ),
                        child: PropertyList(),
                      );
                    case LandingMapState():
                      return BirdViewScreen(
                        getBirdView: getIt<GetBirdView>(),
                      );

                    case LandingSavedState():
                      return BlocProvider(
                        create: (context) => SavedBloc(),
                        child: const SavedPage(),
                      );
                    case LandingProfileState():
                      return BlocProvider(
                        create: (context) => ProfileBloc(),
                        child: ProfilePage(),
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
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          child: BottomNavigationBar(
                            //landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
                            type: BottomNavigationBarType.fixed,
                            backgroundColor: Colors.white,
                            selectedItemColor: Colors.amber,
                            unselectedItemColor: Colors.grey,
                            currentIndex: landingBloc.currentIndex,
                            showSelectedLabels: true,
                            showUnselectedLabels: true,
                            elevation: 5,
                            items: [
                              BottomNavigationBarItem(
                                  icon: Image.asset(
                                    propertiesPng,
                                    height: 30,
                                    width: 30,
                                    color: landingBloc.currentItem ==
                                            BottomBarItems.propertyList
                                        ? kPrimaryColor
                                        : kSecondaryColor,
                                  ),
                                  label: BottomBarItems.propertyList.label),
                              BottomNavigationBarItem(
                                icon: Icon(
                                  Icons.map,
                                  size: 30,
                                  color: landingBloc.currentItem ==
                                          BottomBarItems.mapView
                                      ? kPrimaryColor
                                      : kSecondaryColor,
                                ),
                                label: BottomBarItems.mapView.label,
                              ),
                              if (enroll != StringConstants.enrollmentTypeAdmin)
                                BottomNavigationBarItem(
                                    icon: Image.asset(
                                      savedPng,
                                      height: 30,
                                      width: 30,
                                      color: landingBloc.currentItem ==
                                              BottomBarItems.saved
                                          ? kPrimaryColor
                                          : kSecondaryColor,
                                    ),
                                    label: BottomBarItems.saved.label),
                              BottomNavigationBarItem(
                                  icon: Image.asset(
                                    profilePng,
                                    height: 30,
                                    width: 30,
                                    color: landingBloc.currentItem ==
                                            BottomBarItems.profile
                                        ? kPrimaryColor
                                        : kSecondaryColor,
                                  ),
                                  label: BottomBarItems.profile.label),
                            ],
                            onTap: (index) =>
                                BlocProvider.of<LandingBloc>(context).add(
                              OnMenuChanged(
                                pageIndex: index,
                                item: enabledItems[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              /* bottomNavigationBar: SafeArea(
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
                      selectedItemColor: kPrimaryColor, // Color for selected icon
                      unselectedItemColor:
                          kSecondaryColor, // Color for unselected icon
                      selectedIconTheme:
                          const IconThemeData(color: kPrimaryColor, size: 30),
                      unselectedIconTheme:
                          const IconThemeData(color: kSecondaryColor, size: 30),
                      currentIndex: landingBloc.currentIndex,
                      onTap: (index) => BlocProvider.of<LandingBloc>(context).add(
                        OnMenuChanged(pageIndex: index),
                      ),
                      //showSelectedLabels: false,
                      //showUnselectedLabels: false,
                      type: BottomNavigationBarType.fixed,
                      items: [
                        BottomNavigationBarItem(
                          icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                propertiesPng, // Add your custom image here
                               /*  height: 30,
                                width: 30, */
                                color: landingBloc.currentIndex == 0
                                    ? kPrimaryColor
                                    : kSecondaryColor,
                              ),
                              /* const SizedBox(
                                height: 4,
                              ),
                              const Text('Properties'), */
                            ],
                          ),
                          label: 'Properties',
                        ),
                        BottomNavigationBarItem(
                          icon: Column(
                            children: [
                              Image.asset(
                                savedPng, // Add your custom image here
                               /*  height: 30,
                                width: 30, */
                                color: landingBloc.currentIndex == 1
                                    ? kPrimaryColor
                                    : kSecondaryColor,
                              ),
                             /*  const SizedBox(
                                height: 4,
                              ),
                              const Text('Saved'), */
                            ],
                          ),
                          label: 'Saved',
                        ),
                        BottomNavigationBarItem(
                          icon: Column(
                            children: [
                              Image.asset(
                                profilePng, // Add your custom image here
                                /* height: 30,
                                width: 30, */
                                color: landingBloc.currentIndex == 2
                                    ? kPrimaryColor
                                    : kSecondaryColor,
                              ),
                              /* const SizedBox(
                                height: 4,
                              ),
                              const Text('Profile'), */
                            ],
                          ),
                          label: 'Profile',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            */
            ),
          );
        },
      ),
    );
  }
}
