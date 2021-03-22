import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapSample extends StatelessWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }

class MapSampleState extends StatelessWidget {
  // Completer<GoogleMapController> _controller = Completer();

  CameraPosition vegasPosition =
      CameraPosition(
          target: LatLng(36.0953103, -115.1992098),
          zoom: 10
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: vegasPosition,
      ),
    );
  }
}
