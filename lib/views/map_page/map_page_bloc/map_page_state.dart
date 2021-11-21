part of 'map_page_bloc.dart';

// ignore: must_be_immutable
abstract class MapPageState extends Equatable {
  Place? place;
  MapPageState(this.place);
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class MapPageInitialState extends MapPageState {
  MapPageInitialState(Place? place) : super(place);
}

// ignore: must_be_immutable
class MapPagePanelState extends MapPageState {
  MapPagePanelState(Place? place) : super(place);
  @override
  List<Object?> get props => [place];
}
