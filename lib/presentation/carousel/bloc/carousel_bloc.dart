import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'carousel_event.dart';
part 'carousel_state.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  CarouselBloc() : super(CarouselInitial()) {
    on<CarouselEvent>((event, emit) {
      debugPrint("Event received: $event");
      switch (event) {
        case OnCarouselNavigationEvent():
          debugPrint("emmitting CarouselCancelTimer");
          emit(CarouselCancelTimer());
          break;
        case OnCarouselResumeEvent():
          debugPrint("emmitting CarouselResumeTimer");
          emit(CarouselResumeTimer());
          break;
      }
    });
  }
}
