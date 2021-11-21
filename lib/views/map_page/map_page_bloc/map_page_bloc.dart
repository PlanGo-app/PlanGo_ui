import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:meta/meta.dart';
import 'package:plango_front/views/nav_bar/nav_bar_bloc/nav_bar_bloc.dart';

part 'map_page_event.dart';
part 'map_page_state.dart';

class MapPageBloc extends Bloc<MapPageEvent, MapPageState> {
  NavBarBloc nvb;
  StreamSubscription? navBarSubscription;

  MapPageBloc({required this.nvb}) : super(MapPageInitialState()) {
    navBarSubscription = nvb.stream.listen((state) {
      print("HERE");
      if (state is NavBarPlaceFound) {
        print("state is NavBarPlaceFound");
        emit(MapPageInitialState());
        emit(MapPagePanelState(state.place));
      }
    });
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

  @override
  Future<void> close() {
    navBarSubscription!.cancel();
    return super.close();
  }
}
