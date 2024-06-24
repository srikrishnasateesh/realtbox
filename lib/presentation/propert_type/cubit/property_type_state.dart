part of 'property_type_cubit.dart';

enum PropertyTypeStatus { initial, loading, loaded, error }


class PropertyTypeState  {
  final PropertyTypeStatus status;
  final List<Category> propertyTypes;
  final int selectedIndex;

  PropertyTypeState({required this.status, required this.propertyTypes, required this.selectedIndex});

  factory PropertyTypeState.initial() {
    return PropertyTypeState(status: PropertyTypeStatus.initial, propertyTypes: [], selectedIndex: 0);
  }

  PropertyTypeState copyWith({PropertyTypeStatus? status, List<Category>? propertyTypes, int? selectedIndex}) {
    return PropertyTypeState(
      status: status ?? this.status,
      propertyTypes: propertyTypes ?? this.propertyTypes,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

}
