import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'property_filetr_event.dart';
part 'property_filetr_state.dart';

class PropertyFiletrBloc extends Bloc<PropertyFiletrEvent, PropertyFiletrState> {
  PropertyFiletrBloc() : super(PropertyFiletrInitial()) {
    on<PropertyFiletrEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
