part of 'map_page_bloc.dart';

@immutable
abstract class MapPageEvent extends Equatable {
  const MapPageEvent();

  @override
  List<Object> get props => [];
}

class MapPageEventInitial extends MapPageEvent {
  const MapPageEventInitial();
}

// ignore: must_be_immutable
class MapPageEventPanel extends MapPageEvent {
  MapBoxPlace place;
  MapPageEventPanel({required this.place});
}
