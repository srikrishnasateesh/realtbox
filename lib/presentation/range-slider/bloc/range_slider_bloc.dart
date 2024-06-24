import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'range_slider_event.dart';
part 'range_slider_state.dart';

class RangeSliderBloc extends Bloc<RangeSliderEvent, RangeSliderState> {
  RangeSliderBloc() : super(RangeSliderInitial()) {
    on<RangeSliderEvent>((event, emit) {
      switch(event){
        
        case OnRangeSliderInit():
         emit(BuildRangeSlider(rangeValues: event.rangeValues));
         break;
        case OnRangeSliderChanged():
        
         emit(BuildRangeSlider(rangeValues: event.rangeValues));
        break;
      }
    });
  }
}
