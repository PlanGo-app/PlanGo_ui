import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

part 'nav_bar_event.dart';
part 'nav_bar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(NavBarInitial()) {
    on<NavBarEventInitial>(_onInitial);
    on<NavBarEventSearch>(_onSearch);
    on<NavBarEventPlaceFound>(_onPlaceFound);
    on<NavBarEventList>(_navBarList);
  }

  FutureOr<void> _onInitial(
      NavBarEventInitial event, Emitter<NavBarState> emit) {
    emit(NavBarInitial());
  }

  FutureOr<void> _onSearch(NavBarEventSearch event, Emitter<NavBarState> emit) {
    emit(NavBarSearch());
  }

  FutureOr<void> _navBarList(NavBarEventList event, Emitter<NavBarState> emit) {
    emit(NavBarList());
  }

  FutureOr<void> _onPlaceFound(
      NavBarEventPlaceFound event, Emitter<NavBarState> emit) {
    emit(NavBarInitial());
    emit(NavBarPlaceFound(event.place));
  }
}
