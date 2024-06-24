import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/domain/entity/amenity.dart';
import 'package:realtbox/domain/usecase/amenity-list.dart';

part 'amenities_event.dart';
part 'amenities_state.dart';

class AmenitiesBloc extends Bloc<AmenitiesEvent, AmenitiesState> {
  final GetAmenityList getAmenityList;
  AmenitiesBloc(this.getAmenityList) : super(AmenitiesInitial()) {
    on<AmenitiesEvent>((event, emit) async {
      switch(event){
        
        case AmenitiesRequested():
         await loadAmenities(event,emit);
         break;
        case AmenitySelected():
          handleSelection(event,emit);
          break;
      }
    });
  }

  handleSelection(AmenitySelected event, Emitter<AmenitiesState> emit) {

    debugPrint("Received Ame: ${event.selectedAmenity}");

    if(state is AmenitiesLoaded){
      final curState = (state as AmenitiesLoaded);
      List<Amenity> seletedList = List<Amenity>.from(curState.amenitiesSelected);
      if(seletedList.contains(event.selectedAmenity)){
        seletedList = seletedList..remove(event.selectedAmenity);
      }else {
        seletedList = seletedList..add(event.selectedAmenity);
      }
      emit(AmenitiesSelectedList(amenitiesSelected: seletedList));
      emit(AmenitiesLoaded(amenities: curState.amenities, amenitiesSelected: seletedList));
    }
  }

  Future<void> loadAmenities(AmenitiesRequested event, Emitter<AmenitiesState> emit) async {
   /* final list =  List<Amenity>.generate(100, (index)=>
      Amenity(id: "index",name: "Amenity-$index")
    );
    emit(AmenitiesLoaded(amenities: list, amenitiesSelected: [])); */
    try {
      final response = await getAmenityList();
      if (response is DataFailed) {
        return;
      }
      if (response is DataSuccess) {
        final list = response.data ?? List.empty();
        emit(AmenitiesLoaded(amenities: list, amenitiesSelected: event.amenitiesSelected));
      }
    } catch (_) {
      emit(AmenitiesLoaded(amenities: [], amenitiesSelected: []));
    }
  }
}
