import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lost_and_found_ui/pop_ups/edit_info.dart';
import 'package:lost_and_found_ui/pop_ups/edit_photos.dart';
import 'api_requests/items.dart';
import 'text.dart';
import 'general_widgets.dart';
import 'google_maps.dart';
import 'models/item.dart';
import 'models/match.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class matchesDetailPage extends StatelessWidget {
  Match match;

  matchesDetailPage(this.match);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: matchesTopBar("0915641892"),
      backgroundColor: Colors.white,
      floatingActionButton: matchSpeedDial,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // ADD CALL TO UPDATE MATCH
      //   },
      //   child: Icon(Icons.done),
      //   backgroundColor: Colors.green,
      // ),
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new DetailHeading(match.lost.title),
            PhotoRow(match.found, "Found item photos:"),
            PhotoRow(match.lost, "Lost item photos:"),
            // new MapRow(item),
          ],
        ),
      ),
    );
  }
}

class PhotoRow extends StatefulWidget {
  PhotoRow(this.item, this.heading);

  String heading;
  Item item;

  @override
  State<StatefulWidget> createState() {
    return _PhotoRowState(item, heading);
  }
}

class _PhotoRowState extends State<PhotoRow> {
  _PhotoRowState(this.item, this.heading);

  String heading;
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
            DetailSubtitle(heading),
            SampleImage,
          ],
        ));
  }
}

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

final matchSpeedDial = new SpeedDial(
  marginEnd: 18,
  marginBottom: 20,
  animatedIcon: AnimatedIcons.menu_arrow,
  animatedIconTheme: IconThemeData(size: 28.0),
  visible: true,
  closeManually: false,
  renderOverlay: false,
  curve: Curves.bounceIn,
  overlayColor: Colors.black,
  overlayOpacity: 0.5,
  tooltip: 'Speed Dial',
  heroTag: 'speed-dial-hero-tag',
  backgroundColor: Colors.lightBlue,
  foregroundColor: Colors.black,
  elevation: 8.0,
  shape: CircleBorder(),
  children: [
    SpeedDialChild(
      child: Icon(Icons.done),
      backgroundColor: Colors.green,
      label: 'Mark resolved',
      labelStyle: TextStyle(fontSize: 18.0),
      onTap: () => print('Accept match pressed'),
      onLongPress: () => print('FIRST CHILD LONG PRESS'),
    ),
    SpeedDialChild(
      child: Icon(Icons.close),
      backgroundColor: Colors.red,
      label: 'Not a match',
      labelStyle: TextStyle(fontSize: 18.0),
      onTap: () => print('Decline match pressed'),
      onLongPress: () => print('THIRD CHILD LONG PRESS'),
    ),
  ],
);
