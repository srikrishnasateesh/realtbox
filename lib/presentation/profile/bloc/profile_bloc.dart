import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      switch (event) {
        case OnProfileInit():
          await handleProfileInit(event, emit);
          break;
        case OnLogoutConfirmed():
          await handleLogout(emit);
          break;
        case OnLoginClicked():
          emit(ProfileNavigation(
            route: RouteNames.authentication,
            removePage: false,
          ));
        case OnMyEnquiriesClicked():
          emit(ProfileNavigation(
            route: RouteNames.userEnquiryList,
            removePage: false,
          ));
      }
    });
  }

  Future<void> handleLogout(Emitter<ProfileState> emit) async {
    SharedPreferences? preferences = await LocalStorage.init();
    await preferences?.clear();
    emit(ProfileNavigation(
      route: RouteNames.splash,
      removePage: true,
    ));
  }

  Future<void> handleProfileInit(
      OnProfileInit event, Emitter<ProfileState> emit) async {
    await LocalStorage.init();
    String token = LocalStorage.getString(StringConstants.token);

    if (token.isEmpty) {
      emit(ShowLoginMessage());
      return;
    }

    String userName = LocalStorage.getString(StringConstants.userName);
    String profileImageUrl =
        LocalStorage.getString(StringConstants.profileImage);
    String mobile = LocalStorage.getString(StringConstants.phoneNumber);
    String email = LocalStorage.getString(StringConstants.userEmail);
    emit(ProfileDataLoaded(
      userName: userName,
      userImageUrl: profileImageUrl,
      mobile: "+91-$mobile",
      email: email.isEmpty ? "--" : email,
    ));
  }
}
