part of 'map_page_bloc.dart';

// ignore: must_be_immutable
abstract class MapPageState extends Equatable {
  MapBoxPlace place;
  MapPageState(this.place);

  @override
  List<Object?> get props => [place];
}

// ignore: must_be_immutable
class MapPageInitialState extends MapPageState {
  MapPageInitialState() : super(MapBoxPlace());
}

// ignore: must_be_immutable
class MapPagePanelState extends MapPageState {
  MapPagePanelState(MapBoxPlace place) : super(place) {}
}
