import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realtbox/presentation/landing/bottom_bar_items.dart';

part 'landing_event.dart';
part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  int currentIndex = 0;
  BottomBarItems currentItem = BottomBarItems.propertyList;
  LandingBloc() : super(LandingInitial()) {
    on<LandingEvent>((event, emit) {
      switch (event) {
        case OnMenuChanged():
          currentIndex = event.pageIndex;
          currentItem = event.item;
         /*  switch (event.pageIndex) {
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
          } */
          switch (currentItem) {
            case BottomBarItems.propertyList:
              emit(LandingHomeState());
              break;
            case BottomBarItems.mapView:
              emit(LandingMapState());
              break;
            case BottomBarItems.saved:
              emit(LandingSavedState());
              break;
            case BottomBarItems.profile:
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
