import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plango_front/views/calendar/calendar.dart';
import 'package:plango_front/views/nav_bar/search_Text_Field.dart';

import 'nav_bar_bloc/nav_bar_bloc.dart';

class NavBar extends StatefulWidget {
  bool onList;
  NavBar({Key? key, required this.onList}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarBloc, NavBarState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          if (state is NavBarSearch) {
            return const SearchTextField();
          } else {
            return Container(
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.black, width: 2))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      if (widget.onList) {
                        Navigator.of(context).pop();
                      }
                      context.read<NavBarBloc>().add(NavBarEventSearch());
                    },
                    child: const Icon(Icons.search),
                    mini: true,
                  ),
                  if (widget.onList) ...[
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.map),
                      mini: true,
                    )
                  ] else ...[
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              Calendar(),
                        ));
                      },
                      child: const Icon(Icons.calendar_today),
                      mini: true,
                    ),
                  ],
                ],
              ),
            );
          }
        });
  }
}
