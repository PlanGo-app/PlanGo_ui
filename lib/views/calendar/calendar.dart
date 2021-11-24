import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plango_front/views/nav_bar/nav_bar_bloc/nav_bar_bloc.dart';

class Calendar extends StatefulWidget {
  Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavBarBloc(),
      child: Scaffold(
        body: body(),
        // bottomNavigationBar: NavBar(
        //   onList: true,
        // ),
      ),
    );
  }
}

class body extends StatelessWidget {
  const body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purpleAccent,
      child: Center(child: Text("Calendrier")),
    );
  }
}
