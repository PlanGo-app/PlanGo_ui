part of 'map_page_bloc.dart';

// ignore: must_be_immutable
abstract class MapPageState extends Equatable {
  // Place place;
  // MapPageState(this.place);
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class MapPageInitialState extends MapPageState {
  MapPageInitialState() : super();
}

// ignore: must_be_immutable
class MapPagePanelState extends MapPageState {
  Place place;
  MapPagePanelState(this.place) : super() {}
  @override
  List<Object?> get props => [place];
}
