import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:meta/meta.dart';

part 'map_page_event.dart';
part 'map_page_state.dart';

class MapPageBloc extends Bloc<MapPageEvent, MapPageState> {
  MapPageBloc() : super(MapPageInitialState()) {
    on<MapPageEventInitial>(_onInitial);
    on<MapPageEventPanel>(_onPanel);
  }

  FutureOr<void> _onInitial(
      MapPageEventInitial event, Emitter<MapPageState> emit) {
    emit(MapPageInitialState());
  }

  FutureOr<void> _onPanel(MapPageEventPanel event, Emitter<MapPageState> emit) {
    emit(MapPagePanelState(event.place));
  }
}
