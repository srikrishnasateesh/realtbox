part of 'landing_bloc.dart';

sealed class LandingEvent extends Equatable {
  const LandingEvent();

  @override
  List<Object> get props => [];
}

class OnAppStarted extends LandingEvent {}

class OnMenuChanged extends LandingEvent {
  final int pageIndex;
  final BottomBarItems item;

  OnMenuChanged({
    required this.pageIndex,
    required this.item,
  });
}
