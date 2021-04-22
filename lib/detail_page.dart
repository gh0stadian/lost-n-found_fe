import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lost_and_found_ui/pop_ups/edit_info.dart';
import 'package:lost_and_found_ui/pop_ups/edit_photos.dart';
import 'api_requests/items.dart';
import 'text.dart';
import 'general_widgets.dart';
import 'google_maps.dart';
import 'models/item.dart';

class DetailPage extends StatelessWidget {
  DetailPage(this.item, this.itemType);

  String itemType;
  Item item;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomTopBar(""),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new DetailHeading(item.title),
            new PhotoRow(item, itemType),
            new InfoRow(item, itemType),
            new MapRow(item, itemType),
          ],
        ),
      ),
    );
  }
}

class PhotoRow extends StatefulWidget {
  PhotoRow(this.item, this.itemType);

  String itemType;
  Item item;

  @override
  State<StatefulWidget> createState() {
    return _PhotoRowState(item, itemType);
  }
}

class _PhotoRowState extends State<PhotoRow> {
  _PhotoRowState(this.item, this.itemType);

  String itemType;
  Item item;

  refreshItem(newItem) {
    setState(() {
      this.item = newItem;
    });
  }

  @override
  initState() {
    super.initState();
    refreshItem(this.item);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 250.0,
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 10.0,
        ),
        alignment: FractionalOffset.topCenter,
        child: new Stack(
          children: <Widget>[
            Box,
            DetailSubtitle("Photos:"),
            SampleImage,
            EditIcon(refreshItem, item, itemType,
                redirection: editPhotosPopUp()),
          ],
        ));
  }
}

class InfoRow extends StatefulWidget {
  InfoRow(this.item, this.itemType);

  String itemType;
  Item item;

  @override
  State<StatefulWidget> createState() {
    return _InfoRowState(item, itemType);
  }
}

class _InfoRowState extends State<InfoRow> {
  _InfoRowState(this.item, this.itemType);

  String itemType;
  Item item;

  refreshItem(newItem) {
    setState(() {
      this.item = newItem;
    });
  }

  @override
  initState() {
    super.initState();
    refreshItem(this.item);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 250.0,
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 10.0,
        ),
        alignment: FractionalOffset.topCenter,
        child: new Stack(
          children: <Widget>[
            Box,
            DetailSubtitle("Information:"),
            EditIcon(refreshItem, item, itemType, redirection: PopUp(item)),
            DetailInformation(
                "brand", item.description, item.category, "model"),
            // SampleImage,
          ],
        ));
  }
}

class MapRow extends StatefulWidget {
  MapRow(this.item, this.itemType);

  String itemType;
  Item item;

  @override
  State<StatefulWidget> createState() {
    return _MapRowState(item, itemType);
  }
}

class _MapRowState extends State<MapRow> {
  _MapRowState(this.item, this.itemType);

  String itemType;
  Item item;

  refreshItem(newItem) {
    setState(() {
      this.item = newItem;
    });
  }

  @override
  initState() {
    super.initState();
    refreshItem(this.item);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 250.0,
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 10.0,
        ),
        alignment: FractionalOffset.topCenter,
        child: new Stack(
          children: <Widget>[
            Map(
              key: UniqueKey(),
              lat: item.latitude,
              long: item.longitude,
            ),
            DetailSubtitle("Location:"),
            EditIcon(refreshItem, item, itemType),
            // MapSampleState(),
          ],
        ));
  }
}

final SampleImage = new Container(
  margin: new EdgeInsets.only(top: 5.0),
  alignment: FractionalOffset.center,
  child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: new Image(
        image: new AssetImage("assets/img/flower.jpg"),
        height: 200.0,
        // width: BoxFit.fitWidth,
        // fit: BoxFit.fitWidth,
        // width: 92.0,
      )),
);

final Box = new Container(
  height: 250.0,
  margin: new EdgeInsets.only(left: 2.0),
  decoration: new BoxDecoration(
    color: new Color(0xFFFFFFFF),
    shape: BoxShape.rectangle,
    borderRadius: new BorderRadius.circular(8.0),
    boxShadow: <BoxShadow>[
      new BoxShadow(
        color: Colors.black12,
        blurRadius: 10.0,
        offset: new Offset(0.0, 10.0),
      ),
    ],
  ),
);

class EditIcon extends StatelessWidget {
  Item item;
  String itemType;
  Widget redirection;

  EditIcon(this.refreshCallback, this.item, this.itemType,
      {Key key, this.redirection})
      : super(key: key);

  Function refreshCallback;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () {
          if (redirection != null) {
            Navigator.of(context).push(popUpRoute(redirection)).then((result) {
              if (result != null) {
                item = result;
                updateItem(item, itemType)
                    .then((value) => refreshCallback(item));
              }
            });
          } else {
            LocationResult result;
            showLocationPicker(
                    context, "AIzaSyASTtgffep6qfXoQ_S_dIsRvaPVIlYVEfM",
                    initialCenter: LatLng(item.latitude, item.longitude))
                .then((value) {
              result = value;
              item.latitude = result.latLng.latitude;
              item.longitude = result.latLng.longitude;
              updateItem(item, itemType).then((value) => refreshCallback(item));
            });
          }
        },
        child: Container(
          alignment: FractionalOffset.topRight,
          margin: new EdgeInsets.only(right: 5.0, top: 5.0),
          child: Icon(
            Icons.edit,
            color: Colors.grey,
            size: 20.0,
          ),
        ));
  }
}

Route popUpRoute(Widget page) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      opaque: false,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;
        // timeDilation = 1.2;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
