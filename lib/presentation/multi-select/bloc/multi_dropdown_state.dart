part of 'multi_dropdown_bloc.dart';

class MultiDropdownState extends Equatable {
  final List<String> items;
  final List<String> selectedItems;

  MultiDropdownState({required this.items, required this.selectedItems});

  @override
  List<Object> get props => [items, selectedItems];

  MultiDropdownState copyWith(
      {List<String>? items, List<String>? selectedItems}) {
    return MultiDropdownState(
      items: items ?? this.items,
      selectedItems: selectedItems ?? this.selectedItems,
    );
  }
}
