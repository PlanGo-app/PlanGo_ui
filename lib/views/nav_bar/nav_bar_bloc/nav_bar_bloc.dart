import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';

part 'nav_bar_event.dart';
part 'nav_bar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(NavBarInitial()) {
    on<NavBarEventInitial>(_onInitial);
    on<NavBarEventSearch>(_onSearch);
    on<NavBarEventPlaceFound>(_onPlaceFound);
  }

  FutureOr<void> _onInitial(
      NavBarEventInitial event, Emitter<NavBarState> emit) {
    emit(NavBarInitial());
  }

  FutureOr<void> _onSearch(NavBarEventSearch event, Emitter<NavBarState> emit) {
    emit(NavBarSearch());
  }

  FutureOr<void> _onPlaceFound(
      NavBarEventPlaceFound event, Emitter<NavBarState> emit) {
    emit(NavBarPlaceFound(event.place));
  }
}