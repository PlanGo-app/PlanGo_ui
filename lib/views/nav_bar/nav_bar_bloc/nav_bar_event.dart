part of 'nav_bar_bloc.dart';

abstract class NavBarEvent extends Equatable {
  const NavBarEvent();
  @override
  List<Object?> get props => [];
}

class NavBarEventInitial extends NavBarEvent {
  const NavBarEventInitial();
}

class NavBarEventSearch extends NavBarEvent {
  const NavBarEventSearch();
}

class NavBarEventList extends NavBarEvent {
  const NavBarEventList();
}

// ignore: must_be_immutable
class NavBarEventPlaceFound extends NavBarEvent {
  Place place;
  bool save;
  LatLng point;
  NavBarEventPlaceFound(
      {required this.place, required this.save, required this.point});
}
