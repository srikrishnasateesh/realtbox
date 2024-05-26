import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realtbox/core/base_bloc.dart';

part 'propert_detail_event.dart';
part 'propert_detail_state.dart';

class PropertDetailBloc extends BaseBlock<PropertDetailEvent, PropertDetailState> {
  PropertDetailBloc() : super(PropertDetailInitial()) {
    on<PropertDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
