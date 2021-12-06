import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:plango_front/model/pin.dart';
import 'package:plango_front/service/country_city_service.dart';
import 'package:plango_front/service/pin_service.dart';
import 'package:plango_front/views/nav_bar/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: must_be_immutable
class MapView extends StatefulWidget {
  int travelId;
  PanelController panelController;
  MapView({Key? key, required this.travelId, required this.panelController})
      : super(key: key);

  MapController mapController = MapController();
  bool isReady = false;
  List<Marker> markers = [];
  // ignore: prefer_function_declarations_over_variables
  Function addMarker = () {};
  // ignore: prefer_function_declarations_over_variables
  Function deleteMarker = () {};

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapView> {
  @override
  void initState() {
    super.initState();
    widget.mapController.onReady.then((value) {
      widget.addMarker = (LatLng point, bool save) {
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
        if (save) {
          CountryCityService()
              .revserseSearch(point.latitude, point.longitude)
              .then((value) {
            if (value != null) {
              PinService().CreatePin(value.displayName, point.longitude,
                  point.latitude, widget.travelId);
              setState(() {
                widget.panelController.show();
                widget.markers.add(m);
              });
            }
          });
        } else {
          setState(() {
            widget.markers.add(m);
            widget.panelController.show();
          });
        }
        widget.isReady = true;
      };

      widget.deleteMarker = (LatLng point, travelId) {
        setState(() {
          widget.panelController.hide();
          widget.markers.removeWhere((marker) => marker.point == point);
          PinService().DeletePin(point.longitude, point.latitude, travelId);
        });
      };
    });

    PinService().getPins(widget.travelId).then((value) {
      for (Pin p in value) {
        widget.addMarker(LatLng(p.latitude, p.longitude), false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(
          onLongPress: (_, latLng) {
            try {
              Marker? existingMarker;
              for (Marker mk in widget.markers) {
                if (mk.point.latitude.toStringAsFixed(3) ==
                        latLng.latitude.toStringAsFixed(3) &&
                    mk.point.longitude.toStringAsFixed(3) ==
                        latLng.longitude.toStringAsFixed(3)) {
                  existingMarker = mk;
                  break;
                }
              }

              CountryCityService()
                  .revserseSearch(latLng.latitude, latLng.longitude)
                  .then((value) {
                if (value != null) {
                  context.read<NavBarBloc>().add(NavBarEventPlaceFound(
                      place: value,
                      point: existingMarker == null
                          ? latLng
                          : existingMarker.point,
                      save: false));
                }
              });
              if (existingMarker == null) {
                widget.addMarker(latLng, true);
              }
              // ignore: empty_catches
            } catch (e) {}
          },
          center: LatLng(50.62925, 3.057256),
          minZoom: 1.0,
          maxZoom: 20.0,
          zoom: 16.0),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(markers: widget.markers),
      ],
    );
  }
}
