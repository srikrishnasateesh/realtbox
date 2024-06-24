part of 'budget_dropdown_bloc.dart';

sealed class BudgetDropdownState {
  const BudgetDropdownState();

}

final class BudgetDropdownInitial extends BudgetDropdownState {}

class DropdownLoading extends BudgetDropdownState {}

class DropdownLoaded extends BudgetDropdownState {
  final List<String> items;
  final String? selectedItem;

  const DropdownLoaded(this.items, this.selectedItem);
}
