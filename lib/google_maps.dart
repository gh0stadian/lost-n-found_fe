import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// TODO UNCOMMENT
// import 'package:google_map_location_picker/google_map_location_picker.dart'
//     as location_picker;

//
// class MapSample extends StatelessWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }

class Map extends StatefulWidget {
  Map({Key key, this.lat, this.long, this.item1coords, this.item2coords})
      : super(key: key);
  final double lat;
  final double long;
  final LatLng item1coords;
  final LatLng item2coords;

  @override
  _MapState createState() => _MapState();
}
// Completer<GoogleMapController> _controller = Completer();

class _MapState extends State<Map> {
  CameraPosition position;
  var markers = <Marker>[];

  @override
  void initState() {
    if (widget.item1coords == null || widget.item2coords == null) {
      this.position =
          CameraPosition(target: LatLng(widget.lat, widget.long), zoom: 15);
      markers.add(Marker(
              markerId: MarkerId("Pin"),
              position: LatLng(widget.lat, widget.long)));
    }
    else {
      LatLng finalCoords = LatLng(
          (widget.item1coords.latitude + widget.item2coords.latitude) / 2,
          (widget.item1coords.longitude + widget.item2coords.longitude) / 2);
      this.position = CameraPosition(target: finalCoords, zoom: 13);
      markers.add(Marker(
              markerId: MarkerId("Item1"),
              position: LatLng(widget.item1coords.latitude, widget.item1coords.longitude))
      );
      markers.add(Marker(
              markerId: MarkerId("Item2"),
              position: LatLng(widget.item2coords.latitude, widget.item2coords.longitude))
      );
    }


    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: position,
        markers: Set<Marker>.of(this.markers),
      ),
    );
  }
}
