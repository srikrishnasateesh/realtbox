part of 'propert_detail_bloc.dart';

sealed class PropertDetailState extends BaseState {
  const PropertDetailState();
}

final class PropertDetailInitial extends PropertDetailState {

  PropertDetailInitial();
}

class RequestProcess extends PropertDetailState {}

class OnEnquirySubmittedSuccessfully extends PropertDetailState {}

