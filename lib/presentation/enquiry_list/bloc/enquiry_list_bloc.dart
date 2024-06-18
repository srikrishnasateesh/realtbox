import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realtbox/core/base_bloc.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/domain/entity/enquiry_list/enquiry_data_model.dart';
import 'package:realtbox/domain/usecase/enquiry_list.dart';

part 'enquiry_list_event.dart';
part 'enquiry_list_state.dart';

class EnquiryListBloc extends BaseBlock<EnquiryListEvent, EnquiryListState> {
  GetEnquiryList enquiryList;
  EnquiryListBloc(this.enquiryList) : super(EnquiryListInitial()) {
    on<EnquiryListEvent>((event, emit) async {
      switch (event) {
        case OnEnquiryListInit():
          await fetcData(event.properyId, emit);
          break;
      }
    });
  }

  Future<void> fetcData(
      String propertyId, Emitter<EnquiryListState> emit) async {
    emit(EnquiryListLoading());
    final response = await enquiryList(params: propertyId);
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
