import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/utils/validation_utils.dart';
import 'package:realtbox/data/model/enquiry/enquiry_request.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/usecase/submit_enquiry.dart';

part 'enquiry_event.dart';
part 'enquiry_state.dart';

class EnquiryBloc extends Bloc<EnquiryEvent, EnquiryState> {
  ValidationUtils utils = getIt<ValidationUtils>();
  String userMobileNumber = "";
  SubmitEnquiry submitEnquiry;
  String propertyId = "";

  EnquiryBloc(this.submitEnquiry) : super(EnquiryInitial()) {
    on<EnquiryEvent>((event, emit) async {
      switch (event) {
        case OnEnquirySubmitted():
          await handleValidations(event, emit);
          break;
        case OnValuesChanged():
          emit(EnquiryInitial());
          break;
        case OnAppStarted():
          await handleAppInit(emit, event);
          break;
        case OnMobileNumberChanged():
          emit(UserMobileNumber(mobile: event.text));
          break;
      }
    });
  }

  Future<void> handleAppInit(
      Emitter<EnquiryState> emit, OnAppStarted event) async {
    propertyId = event.id;
    await LocalStorage.init();
    String mobile = LocalStorage.getString(StringConstants.phoneNumber);
    emit(UserMobileNumber(mobile: mobile));
  }

  Future<void> handleValidations(
      OnEnquirySubmitted event, Emitter<EnquiryState> emit) async {
    String mobileNumber = event.mobileNumber;
    String message = event.message;
    if (!utils.validateMobile(mobileNumber)) {
      emit(EnquiryValidationFailed(message: "Mobile number required"));
      return;
    }
    if (message.isEmpty) {
      emit( EnquiryValidationFailed(message: "Message required"));
      return;
    }
    await handleEnquirySubmit(emit,mobileNumber,message);
  }

  Future<void> handleEnquirySubmit(
      Emitter<EnquiryState> emit, String mobile, String message) async {
    emit(ShowProgress());
    final response = await submitEnquiry(
        params: EnquiryRequestObject(
            enquiryRequest:
                EnquiryRequest(phoneNumber: mobile, message: message),
            propertyId: propertyId));
    if (response is DataSuccess) {
      emit(ShowConfirmationMessage(
          message: "Your response received successfully"));
    } else {
      debugPrint("$response");
      emit(ShowError(message: "Something went wrong, Please try again"));
    }
  }
}
