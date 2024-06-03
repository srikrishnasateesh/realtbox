part of 'carousel_bloc.dart';

sealed class CarouselEvent extends Equatable {
  const CarouselEvent();

  @override
  List<Object> get props => [];
}

class OnCarouselNavigationEvent extends CarouselEvent {}

class OnCarouselResumeEvent extends CarouselEvent {}
