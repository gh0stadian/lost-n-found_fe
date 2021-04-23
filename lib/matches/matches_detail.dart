import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lost_and_found_ui/pop_ups/edit_info.dart';
import 'package:lost_and_found_ui/pop_ups/edit_photos.dart';
import '../api_requests/items.dart';
import '../auth.dart';
import '../text.dart';
import '../general_widgets.dart';
import '../google_maps.dart';
import '../models/item.dart';
import '../models/match.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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
            Gallery(item),
            // SampleImage,
          ],
        ));
  }
}

class Gallery extends StatefulWidget {
  Item item;

  // List<Image> loadedImages;

  Gallery(this.item);

  @override
  State<StatefulWidget> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  initState() {
    super.initState();
    // if (widget.item.images.length == 0){
    //   widget.item.images[0] = "6b42759d-83e6-47b3-beec-347d09c2eead.png"
    //   ;
    // }
  }
  
  getImage(int index){
    if (widget.item.images.length == 0) {
      print("Loading asset");
      return AssetImage('assets/img/default.jpg');
    }
    else {
      return NetworkImage(
          'http://${GlobalData.serverAddress}/api/files/download/'
              '${widget.item.id}/${widget.item.images[index]}',
          headers: {'Authorization': GlobalData.jwt},
      );
      }
  }

  @override
  Widget build(BuildContext context) {
    int listLength = widget.item.images.length;

    if (listLength == 0){
      listLength = 1;
    }
    return Container(
        height: 200.0,
        // width: 300.0,
        margin: new EdgeInsets.only(top: 30.0, right: 20, left: 20),
        alignment: FractionalOffset.center,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: getImage(index),
                  initialScale: PhotoViewComputedScale.contained,
                );
              },
              itemCount: listLength,
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(),
                ),
              ),
              backgroundDecoration: BoxDecoration(color: Colors.white),
              // pageController: widget.pageController,
              // onPageChanged: onPageChanged,
            )));
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