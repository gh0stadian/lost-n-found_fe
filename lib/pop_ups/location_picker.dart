import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../found_item.dart';
import '../google_maps.dart';
import 'package:lost_and_found_ui/api_requests/items.dart';
import 'package:lost_and_found_ui/api_requests/metadata.dart';
import 'package:lost_and_found_ui/models/item.dart';
import '../lost_item.dart';
import '../text.dart';
import 'edit_photos.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';

class LocationPickerPopup extends StatefulWidget {
  LocationPickerPopup(this.item, this.itemType);

  final Item item;
  final String itemType;

  @override
  State<StatefulWidget> createState() =>
      _LocationPickerPopupState(item, itemType);
}

class _LocationPickerPopupState extends State<LocationPickerPopup> {
  _LocationPickerPopupState(this.item, this.itemType);

  Item item;
  String itemType;
  LatLng coords;
  List<Widget> content = [];

  pickLocation() {
    LocationResult result;
    showLocationPicker(
      context,
      "AIzaSyASTtgffep6qfXoQ_S_dIsRvaPVIlYVEfM",
    ).then((value) {
      result = value;
      item.latitude = result.latLng.latitude;
      item.longitude = result.latLng.longitude;
      refresh(item);
    });
  }

  refresh(Item item) {
    setState(() {
      this.content = <Widget>[
        Container(
            height: 250,
            alignment: Alignment.topCenter,
            child: Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 20, bottom: 20, right: 15),
                child: Container(
                  height: 250,
                  child: Map(
                    key: UniqueKey(),
                    lat: item.latitude,
                    long: item.longitude,
                  ), // MapSampleState(),
                )))
      ];
    });
  }

  @override
  initState() {
    content = <Widget>[
      Container(
          height: 200,
          alignment: Alignment.center,
          child: Padding(
              padding:
                  EdgeInsets.only(left: 15, top: 100, bottom: 20, right: 15),
              child: Container(
                  height: 55,
                  child: MaterialButton(
                    elevation: 5.0,
                    minWidth: 300,
                    height: 40,
                    color: Colors.blue.shade600,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.pin_drop_outlined,
                          color: Colors.black,
                        ),
                        SizedBox(width: 65),
                        Text(
                          "Pick a location",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    onPressed: pickLocation,
                  )))),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Container(
          decoration:
              new BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: new Text(
              "Pick a location",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0),
            content: Container(
                width: 400,
                height: 250,
                child: Column(
                  children: content,
                )),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Back"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                elevation: 5.0,
                child: Text("Done"),
                onPressed: () {
                  updateItem(item, itemType).then((value) {
                    if (widget.itemType == "lost") {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => LostItemPage(),
                      ));
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => FoundItemPage(),
                      ));
                    }
                  });
                },
              ),
            ],
          ),
        ));
  }
}
