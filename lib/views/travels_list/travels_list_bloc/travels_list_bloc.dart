import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'travels_list_event.dart';
part 'travels_list_state.dart';

class TravelsListBloc extends Bloc<TravelsListEvent, TravelsListState> {
  TravelsListBloc() : super(TravelsListInitial()) {
    on<TravelsListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
