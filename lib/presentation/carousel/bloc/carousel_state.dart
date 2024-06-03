part of 'carousel_bloc.dart';

sealed class CarouselState extends Equatable {
  const CarouselState();
  
  @override
  List<Object> get props => [];
}

final class CarouselInitial extends CarouselState {}

final class CarouselCancelTimer extends CarouselState {}

final class CarouselResumeTimer extends CarouselState {}