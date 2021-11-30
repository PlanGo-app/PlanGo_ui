import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  MapView({Key? key}) : super(key: key);
  MapController mapController = MapController();
  bool isReady = false;
  List<Marker> markers = [];
  // ignore: prefer_function_declarations_over_variables
  Function addMarker = () {};

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapView> {
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    widget.mapController.onReady.then((value) => widget.isReady = true);
    widget.addMarker = (LatLng point) {
      Marker m = Marker(
        width: 45.0,
        height: 45.0,
        point: point,
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 35.0,
        ),
      );
      print(point);
      setState(() {
        markers.add(m);
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(
          onLongPress: (_, latLng) {
            widget.addMarker(latLng);
          },
          // center: LatLng(50.62925, 3.057256),
          minZoom: 5.0,
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
}
