import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';

import 'nav_bar_bloc/nav_bar_bloc.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    Key? key,
  }) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return const NavBarView();
  }
}

class NavBarView extends StatefulWidget {
  const NavBarView({Key? key}) : super(key: key);

  @override
  _NavBarViewState createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarBloc, NavBarState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          if (state is NavBarSearch) {
            return Row(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    context
                        .read<NavBarBloc>()
                        .add(NavBarEventPlaceFound(place: MapBoxPlace()));
                  },
                  child: Icon(Icons.more_horiz_outlined),
                  mini: true,
                ),
                Flexible(child: TextField()),
              ],
            );
          } else {
            return Row(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    context.read<NavBarBloc>().emit(NavBarSearch());
                  },
                  child: Icon(Icons.search),
                  mini: true,
                ),
                FloatingActionButton(
                  onPressed: () {
                    context.read<NavBarBloc>().emit(NavBarInitial());
                  },
                  child: Icon(Icons.list),
                  mini: true,
                ),
              ],
            );
          }
        });
  }
}
