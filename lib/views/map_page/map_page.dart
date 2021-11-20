import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:plango_front/views/components/small_rounded_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'map_page_bloc/map_page_bloc.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapPageBloc(),
      child: const MapPageView(),
    );
  }
}

class MapPageView extends StatefulWidget {
  const MapPageView({Key? key}) : super(key: key);

  @override
  _MapPageViewState createState() => _MapPageViewState();
}

class _MapPageViewState extends State<MapPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapViewBody(),
      bottomNavigationBar: Row(
        children: [
          SmallRoundedButton(
              text: "Panel",
              press: () {
                context
                    .read<MapPageBloc>()
                    .add(MapPageEventPanel(place: MapBoxPlace()));
              }),
          SmallRoundedButton(
              text: "NoPanel",
              press: () {
                context.read<MapPageBloc>().add(const MapPageEventInitial());
              }),
        ],
      ),
    );
  }
}

class MapViewBody extends StatelessWidget {
  const MapViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<MapPageBloc, MapPageState>(
    //     buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
    //     builder: (context, state) {
    //       if (state is MapPageInitialState) {
    //         return _Map();
    //       } else {
    //         return SlidingUpPanel(
    //           parallaxEnabled: true,
    //           panel: Container(color: Colors.purpleAccent),
    //           body: _Map(),
    //         );
    //       }
    //     });
    return _Map();
  }

  Widget _Map() {
    return FlutterMap(
      options: MapOptions(
          center: LatLng(51, 30), minZoom: 10.0, maxZoom: 20.0, zoom: 16.0),
      layers: [
        TileLayerOptions(
            // urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            // subdomains: ['a', 'b', 'c'],
            urlTemplate: "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png",
            attributionBuilder: (_) {
              return Text("© OpenStreetMap contributors");
            }),
      ],
    );
  }
}
