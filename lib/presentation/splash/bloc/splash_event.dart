part of 'splash_bloc.dart';

@immutable
sealed class SplashEvent extends BaseEvent {}

class OnSplashScrennShown extends SplashEvent {}

class OnSkipVersion extends SplashEvent {}

