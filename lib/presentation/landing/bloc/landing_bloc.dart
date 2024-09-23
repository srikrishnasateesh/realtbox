import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'landing_event.dart';
part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  int currentIndex = 0;
  LandingBloc() : super(LandingInitial()) {
    on<LandingEvent>((event, emit) {
      switch (event) {
        case OnMenuChanged():
          currentIndex = event.pageIndex;
          switch (event.pageIndex) {
            case 0:
              emit(LandingHomeState());
              break;
            case 1:
              emit(LandingMapState());
              break;
            case 2:
              emit(LandingSavedState());
              break;
            case 3:
              emit(LandingProfileState());
              break;
          }

          break;
        case OnAppStarted():
          emit(LandingHomeState());
          break;
      }
    });
  }
}
