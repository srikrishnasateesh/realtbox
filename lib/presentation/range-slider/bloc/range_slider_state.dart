part of 'range_slider_bloc.dart';

sealed class RangeSliderState extends Equatable {
  const RangeSliderState();
  
  @override
  List<Object> get props => [];
}

final class RangeSliderInitial extends RangeSliderState {}

final class BuildRangeSlider extends RangeSliderState {
  final RangeValues rangeValues;

  BuildRangeSlider({required this.rangeValues});
}
