import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart'
    as location_picker;

//
// class MapSample extends StatelessWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }

class Map extends StatefulWidget {
  Map({Key key, this.lat, this.long}) : super(key: key);
  final double lat;
  final double long;

  @override
  _MapState createState() => _MapState();
}
// Completer<GoogleMapController> _controller = Completer();

class _MapState extends State<Map> {
  CameraPosition position;

  @override
  void initState() {
    this.position =
        CameraPosition(target: LatLng(widget.lat, widget.long), zoom: 15);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: position,
        markers: Set<Marker>.of(<Marker>[
          Marker(
              markerId: MarkerId("Pin"),
              position: LatLng(widget.lat, widget.long))
        ]),
      ),
    );
  }
}
