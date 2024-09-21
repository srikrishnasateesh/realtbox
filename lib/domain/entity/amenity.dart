import 'package:equatable/equatable.dart';

class Amenity extends Equatable {
  final String id;
  final String name;
  final String icon;

  const Amenity({
    required this.id,
    required this.name,
    required this.icon,
  });

  @override
  List<Object?> get props => [id, name];

 /*   @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Amenity otherPerson = other as Amenity;
    return name == otherPerson.name && id == otherPerson.id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode; */
}
