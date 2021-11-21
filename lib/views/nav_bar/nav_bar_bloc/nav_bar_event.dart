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

class NavBarEventPlaceFound extends NavBarEvent {
  MapBoxPlace place;
  NavBarEventPlaceFound({required this.place});
}
