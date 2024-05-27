import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/core/base_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends BaseBlock<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
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
    /* await Future.delayed(const Duration(seconds: 1)).then((value) => {
          if (token.isNotEmpty)
            emit(SplashNavigate(RouteNames.propertyList))
          else
            emit(SplashNavigate(RouteNames.login))
        }); */
  }

  Future<void> initDefaults() async {
    await LocalStorage.init();
    await LocalStorage.setString("myKey", "myValue");
    
  }
}
