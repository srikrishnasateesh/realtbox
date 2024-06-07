import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:realtbox/core/base_bloc.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/data/model/enquiry/enquiry_request.dart';
import 'package:realtbox/domain/usecase/submit_enquiry.dart';

part 'propert_detail_event.dart';
part 'propert_detail_state.dart';

class PropertDetailBloc
    extends BaseBlock<PropertDetailEvent, PropertDetailState> {
  bool refresh = true;
  SubmitEnquiry submitEnquiry;
  PropertDetailBloc(this.submitEnquiry) : super(PropertDetailInitial()) {
    on<PropertDetailEvent>((event, emit) async {
      switch (event) {
        case PropertyDetailResumed():
          break;
        case OnEnquiryReceived():
          await handleEnquirySubmit(emit, event);
          break;
      }
    });
  }

  Future<void> handleEnquirySubmit(
      Emitter<PropertDetailState> emit, OnEnquiryReceived event) async {
    emit(RequestProcess());
    final response = await submitEnquiry(
        params: EnquiryRequestObject(
            enquiryRequest: EnquiryRequest(
                phoneNumber: event.mobile, message: event.message),
            propertyId: event.propertyId));
    if (response is DataSuccess) {
      emit(OnEnquirySubmittedSuccessfully());
    } else {
      debugPrint("$response");
    }
  }
}
