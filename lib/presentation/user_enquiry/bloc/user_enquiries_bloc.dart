import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/domain/entity/user_enquiry.dart';
import 'package:realtbox/domain/usecase/user_enquiry_list.dart';

part 'user_enquiries_event.dart';
part 'user_enquiries_state.dart';

class UserEnquiriesBloc extends Bloc<UserEnquiriesEvent, UserEnquiriesState> {
  final GetUserEnquiryList getUserEnquiryList;
  UserEnquiriesBloc(this.getUserEnquiryList) : super(UserEnquiriesInitial()) {
    on<UserEnquiriesEvent>((event, emit) async {
      switch (event) {
        case OnEnquiryListInit():
          await fetcData(emit);
      }
    });
  }

  Future<void> fetcData(Emitter<UserEnquiriesState> emit) async {
    emit(EnquiryListLoading());
    final response = await getUserEnquiryList();
    if (response is DataFailed) {
      emit(EnquiryListLoaded(data: List.empty()));
      return;
    }

    if (response is DataSuccess) {
      final list = response.data ?? List.empty();
      emit(EnquiryListLoaded(data: list));
    }
  }
}
