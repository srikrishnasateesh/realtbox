import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realtbox/domain/entity/category-type/category.dart';

part 'budget_dropdown_event.dart';
part 'budget_dropdown_state.dart';

class BudgetDropdownBloc extends Bloc<BudgetDropdownEvent, BudgetDropdownState> {
  BudgetDropdownBloc() : super(BudgetDropdownInitial()) {
    on<BudgetDropdownEvent>((event, emit) async{
      switch(event){
        
        case LoadDropdownItems():
        await loadData(event,emit);
        break;
        case SelectDropdownItem():
        handleSelectedItem(event,emit);
        break;
      }
    });
  }

  Future<void> loadData(LoadDropdownItems event, Emitter<BudgetDropdownState> emit) async{
    await Future.delayed(const Duration(seconds: 1));
    final list = ["Select Item",'Item 1', 'Item 2', 'Item 3'];
     emit(DropdownLoaded(list,null));
  }

  handleSelectedItem(SelectDropdownItem event, Emitter<BudgetDropdownState> emit){
     emit(DropdownLoaded((state as DropdownLoaded).items,event.selectedItem));
  }
}
