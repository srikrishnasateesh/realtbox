part of 'saved_bloc.dart';

sealed class SavedState extends Equatable {
  const SavedState();
  
  @override
  List<Object> get props => [];
}

final class SavedInitial extends SavedState {}
