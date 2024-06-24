part of 'multi_dropdown_bloc.dart';


abstract class MultiDropdownEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemSelected extends MultiDropdownEvent {
  final String item;

  ItemSelected(this.item);

  @override
  List<Object> get props => [item];
}

class ItemDeselected extends MultiDropdownEvent {
  final String item;

  ItemDeselected(this.item);

  @override
  List<Object> get props => [item];
}

class SetItems extends MultiDropdownEvent {
  final List<String> items;

  SetItems(this.items);

  @override
  List<Object> get props => [items];
}

