part of 'map_page_bloc.dart';

// ignore: must_be_immutable
abstract class MapPageState extends Equatable {
  Place? place;
  bool save;
  LatLng point;
  MapPageState(this.place, this.point, this.save);
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class MapPageInitialState extends MapPageState {
  MapPageInitialState(Place? place) : super(place, LatLng(0, 0), false);
}

// ignore: must_be_immutable
class MapPagePanelState extends MapPageState {
  MapPagePanelState(Place? place, LatLng point, bool save)
      : super(place, point, save);
  @override
  List<Object?> get props => [place];
}
