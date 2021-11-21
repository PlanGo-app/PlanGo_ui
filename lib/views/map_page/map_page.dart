import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:plango_front/views/nav_bar/nav_bar.dart';
import 'package:plango_front/views/nav_bar/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'map_page_bloc/map_page_bloc.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NavBarBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              MapPageBloc(nvb: context.read<NavBarBloc>()),
        ),
      ],
      child: Scaffold(body: MapPageView()),
    );
  }
}

class MapPageView extends StatefulWidget {
  const MapPageView({
    Key? key,
  }) : super(key: key);

  @override
  _MapPageViewState createState() => _MapPageViewState();
}

class _MapPageViewState extends State<MapPageView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MapViewBody(),
      bottomNavigationBar: NavBar(),
    );
  }
}

class MapViewBody extends StatefulWidget {
  const MapViewBody({Key? key}) : super(key: key);

  @override
  _MapViewBodyState createState() => _MapViewBodyState();
}

class _MapViewBodyState extends State<MapViewBody> {
  List<Marker> markers = [
    Marker(
      width: 45.0,
      height: 45.0,
      point: LatLng(50.62925, 3.057256),
      builder: (ctx) => const Icon(
        Icons.location_on,
        color: Colors.red,
        size: 35.0,
      ),
    ),
    Marker(
      width: 45.0,
      height: 45.0,
      point: LatLng(50.95926, 3.057257),
      builder: (ctx) => const Icon(
        Icons.location_on,
        color: Colors.red,
        size: 35.0,
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapPageBloc, MapPageState>(builder: (context, state) {
      if (state is MapPagePanelState) {
        print(state.place.geometry.coordinates);
        print(LatLng(state.place.geometry.coordinates[1],
            state.place.geometry.coordinates[0]));
        // PanelController _pc = PanelController();
        return SlidingUpPanel(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
          // controller: _pc,
          panelBuilder: (sc) => _panel(sc, context, state.place),
          backdropEnabled: true,
          body: _Map(state.place.geometry),
        );
      } else {
        return _Map(Geometry(coordinates: [3.057256, 50.62925]));
      }
    });
  }

  Widget _Map(Geometry geo) {
    return FlutterMap(
      options: MapOptions(
          onLongPress: (_, latLng) {
            setState(() {
              Marker m = Marker(
                width: 45.0,
                height: 45.0,
                point: latLng,
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 35.0,
                ),
              );
              print(latLng);
              markers.add(m);
            });
          },
          center: LatLng(geo.coordinates[1], geo.coordinates[0]),
          minZoom: 10.0,
          maxZoom: 20.0,
          zoom: 16.0),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(markers: markers),
      ],
    );
  }

  _panel(
    ScrollController sc,
    BuildContext context,
    MapBoxPlace mb,
  ) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
        ),
        child: ListView(
          children: [
            ListTile(title: Text(mb.placeName)),
          ],
        ),
      ),
    );
  }
}
