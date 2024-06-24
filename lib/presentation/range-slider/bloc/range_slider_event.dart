part of 'range_slider_bloc.dart';

sealed class RangeSliderEvent extends Equatable {
  const RangeSliderEvent();

  @override
  List<Object> get props => [];
}

class OnRangeSliderInit extends RangeSliderEvent{
  final RangeValues rangeValues;

  OnRangeSliderInit({required this.rangeValues});
}

class OnRangeSliderChanged extends RangeSliderEvent{
  final RangeValues rangeValues;

  OnRangeSliderChanged({required this.rangeValues});
}
