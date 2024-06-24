part of 'budget_dropdown_bloc.dart';

sealed class BudgetDropdownEvent extends Equatable {
  const BudgetDropdownEvent();

  @override
  List<Object> get props => [];
}

class LoadDropdownItems extends BudgetDropdownEvent {}

class SelectDropdownItem extends BudgetDropdownEvent {
  final String selectedItem;

  const SelectDropdownItem(this.selectedItem);
}

