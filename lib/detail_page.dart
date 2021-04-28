import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// TODO UNCOMMENT
// import 'package:google_map_location_picker/google_map_location_picker.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lost_and_found_ui/pop_ups/edit_info.dart';
import 'package:lost_and_found_ui/pop_ups/edit_photos.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'api_requests/items.dart';
import 'auth.dart';
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
      appBar: detailTopBar(item, itemType),
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
            // ItemThumbnail(item),
            Gallery(item),
            EditIcon(refreshItem, item, itemType,
                redirection: editPhotosPopUp(item)),
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
        margin: new EdgeInsets.only(top: 30.0, right: 20, left: 20, bottom:10),
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

// class ItemThumbnail extends StatelessWidget {
//   ItemThumbnail(this.item);
//
//   Item item;
//
//   getImage(Item item){
//     if (item.images.length == 0) {
//       print("Loading asset");
//       return AssetImage('assets/img/default.jpg');
//     }
//     else {
//       return NetworkImage(
//         'http://${GlobalData.serverAddress}/api/files/download/'
//             '${item.id}/${item.images[0]}',
//         headers: {'Authorization': GlobalData.jwt},
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: new EdgeInsets.only(left: 20.0, right: 20, top: 50),
//       alignment: FractionalOffset.topCenter,
//       child: ClipRRect(
//           borderRadius: BorderRadius.circular(8.0),
//           child: new Image(
//             image: getImage(item),
//             // height: 200.0,
//             // width: BoxFit.fitWidth,
//             fit: BoxFit.contain,
//             // width: 92.0,
//           )
//       ),
//     );
//   }
// }

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
            // TODO UNCOMMENT
            // LocationResult result;
            // showLocationPicker(
            //         context, "AIzaSyASTtgffep6qfXoQ_S_dIsRvaPVIlYVEfM",
            //         initialCenter: LatLng(item.latitude, item.longitude))
            //     .then((value) {
            //   result = value;
            //   item.latitude = result.latLng.latitude;
            //   item.longitude = result.latLng.longitude;
            //   updateItem(item, itemType).then((value) => refreshCallback(item));
            // });
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
