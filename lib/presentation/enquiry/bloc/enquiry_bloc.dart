import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/core/utils/validation_utils.dart';
import 'package:realtbox/di.dart';

part 'enquiry_event.dart';
part 'enquiry_state.dart';

class EnquiryBloc extends Bloc<EnquiryEvent, EnquiryState> {
  ValidationUtils utils = getIt<ValidationUtils>();
  String userMobileNumber = "";

  EnquiryBloc() : super(EnquiryInitial()) {
    on<EnquiryEvent>((event, emit) async {
      switch (event) {
        case OnEnquirySubmitted():
          handleValidations(event, emit);
          break;
        case OnValuesChanged():
          emit(EnquiryInitial());
          break;
        case OnAppStarted():
          await handleAppInit(emit);
          break;
        case OnMobileNumberChanged():
          emit(UserMobileNumber(mobile: event.text));
          break;
      }
    });
  }

  Future<void> handleAppInit(Emitter<EnquiryState> emit) async {
    debugPrint("handleAppInit");
    await LocalStorage.init();
    String mobile = LocalStorage.getString(StringConstants.phoneNumber);
    debugPrint("handleAppInit: $mobile");
    emit(UserMobileNumber(mobile: mobile));
  }

  void handleValidations(OnEnquirySubmitted event, Emitter<EnquiryState> emit) {
    String mobileNumber = event.mobileNumber;
    String message = event.message;
    if (!utils.validateMobile(mobileNumber)) {
      emit(const EnquiryValidationFailed(message: "Mobile number required"));
      return;
    }
    if (message.isEmpty) {
      emit(const EnquiryValidationFailed(message: "Message required"));
      return;
    }
    emit(EnquiryValidationSuccess());
  }
}
