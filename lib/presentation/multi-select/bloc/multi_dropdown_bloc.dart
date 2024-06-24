import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'multi_dropdown_event.dart';
part 'multi_dropdown_state.dart';

class MultiDropdownBloc extends Bloc<MultiDropdownEvent, MultiDropdownState> {
  MultiDropdownBloc() : super(MultiDropdownState(items: [],selectedItems: [])){
    on<MultiDropdownEvent>((event,emit) async{
      mapEventToState(event,emit);
    });
  }

  Stream<MultiDropdownState> mapEventToState(MultiDropdownEvent event, Emitter<MultiDropdownState> emit) async* {
    if (event is ItemSelected) {
      final updatedSelectedItems = List<String>.from(state.selectedItems)..add(event.item);
      //yield state.copyWith(selectedItems: updatedSelectedItems);
      emit(MultiDropdownState(items: state.items, selectedItems: updatedSelectedItems));
    } else if (event is ItemDeselected) {
      final updatedSelectedItems = List<String>.from(state.selectedItems)..remove(event.item);
      //yield state.copyWith(selectedItems: updatedSelectedItems);
      emit(MultiDropdownState(items: state.items, selectedItems: updatedSelectedItems));
    } else if (event is SetItems) {
      //yield state.copyWith(items: event.items);
      emit(MultiDropdownState(items: event.items, selectedItems: state.selectedItems));
    }
  }

}
