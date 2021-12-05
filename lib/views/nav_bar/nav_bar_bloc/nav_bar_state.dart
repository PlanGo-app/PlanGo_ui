part of 'nav_bar_bloc.dart';

abstract class NavBarState extends Equatable {
  const NavBarState();
  @override
  List<Object> get props => [];
}

class NavBarInitial extends NavBarState {}

class NavBarSearch extends NavBarState {}

class NavBarList extends NavBarState {}

class NavBarPlaceFound extends NavBarState {
  Place place;
  bool save;
  LatLng point;
  NavBarPlaceFound(this.place, this.save, this.point);
}
