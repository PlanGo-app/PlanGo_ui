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
  NavBarEventPlaceFound({required this.place});
}
