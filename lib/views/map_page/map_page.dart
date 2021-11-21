import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
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
      child: const Scaffold(body: MapPageView()),
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

  late MapController mapController;
  bool isReady = false;
  late PanelController panelController;

  @override
  void initState() {
    super.initState();

    mapController = MapController();
    mapController.onReady.then((value) => isReady = true);
    panelController = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    // final map = _Map();
    // return BlocBuilder<MapPageBloc, MapPageState>(builder: (context, state) {
    //   if (state is MapPagePanelState) {
    //     if (isReady) {
    //       mapController.move(LatLng(state.place.lat, state.place.lon), 16.0);
    //     }
    //     return SlidingUpPanel(
    //       controller: panelController,
    //       borderRadius: const BorderRadius.only(
    //         topLeft: Radius.circular(18.0),
    //         topRight: Radius.circular(18.0),
    //       ),
    //       // controller: _pc,
    //       panelBuilder: (sc) => _panel(sc, context, state.place),
    //       backdropEnabled: true,
    //       body: map,
    //     );
    //   } else {
    //     return map;
    //   }
    // });
    return BlocBuilder<MapPageBloc, MapPageState>(builder: (context, state) {
      if (state is MapPageInitialState) {
        // panelController.hide();
      }
      if (state is MapPagePanelState) {
        panelController.show();
        if (isReady) {
          mapController.move(LatLng(state.place!.lat, state.place!.lon), 16.0);
        }
      }

      return SlidingUpPanel(
          controller: panelController,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
          // controller: _pc,
          panelBuilder: (sc) => _panel(sc, context, state.place),
          backdropEnabled: true,
          body: _Map());
    });
  }

  Widget _Map() {
    return FlutterMap(
      mapController: mapController,
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
              // Controller._controller.move(latLng, 16);
            });
          },
          center: LatLng(50.62925, 3.057256),
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
    Place? place,
  ) {
    if (place == null) {
      panelController.hide();
    }
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
            ListTile(title: Text(place == null ? "Hello" : place.displayName)),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    panelController.hide();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
