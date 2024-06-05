import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/core/base_bloc.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/domain/usecase/get_user_self.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends BaseBlock<SplashEvent, SplashState> {
  GetUserSelf getUserSelf;
  SplashBloc(this.getUserSelf) : super(SplashInitial()) {
    on<SplashEvent>((event, emit) async {
      switch (event) {
        case OnSplashScrennShown():
          await handleSplashInitState(event, emit);
          break;
      }
    });
  }
  Future handleSplashInitState(
    OnSplashScrennShown event,
    Emitter<SplashState> emit,
  ) async {
    await initDefaults();
    String token = LocalStorage.getString(StringConstants.token);
    debugPrint("token: $token");
    //emit(SplashNavigate(RouteNames.dummy));
    await Future.delayed(const Duration(seconds: 1)).then((value) async => {
          if (token.isNotEmpty){
            await self(emit),
            emit(SplashNavigate(RouteNames.landing))
          }
          else
            emit(SplashNavigate(RouteNames.login))
        });
  }

  Future<void> self(Emitter<SplashState> emit) async {
    createDio();
    final response = await getUserSelf();

    if (response is DataFailed) {
      String msg = response.exception?.message ?? "User self failed";
      emit(SplashError(message: msg));
      return;
    }
    if (response is DataSuccess) {
      final self = response.data;
      await LocalStorage.setString(
        StringConstants.userName,
        self?.name ?? " ",
      );

      await LocalStorage.setString(
        StringConstants.profileImage,
        self?.profileImageUrl ?? "",
      );
    }
  }

  Future<void> initDefaults() async {
    await LocalStorage.init(); 
  }
}
