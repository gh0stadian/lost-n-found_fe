import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'text.dart';
import 'general_widgets.dart';
import 'google_maps.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomTopBar(""),
      backgroundColor: Colors.white,
      // bottomNavigationBar: ,
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new DetailHeading("Item title"),
            new PhotoRow(),
            new InfoRow(),
            new MapRow(),
          ],
        ),
      ),
    );
  }
}

class PhotoRow extends StatelessWidget {
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
            EditIcon("")
          ],
        ));
  }
}

class InfoRow extends StatelessWidget {
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
            EditIcon(""),
            DetailInformation("brand", "description", "category", "model"),
            // SampleImage,
          ],
        ));
  }
}

class MapRow extends StatelessWidget {
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
            DetailSubtitle("Location:"),
            EditIcon(""),
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
    )
  ),
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
  final String redirection;
  // Widget Function() redirection,

  EditIcon(this.redirection, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){
    // Navigator.push(
      // context,
      // MaterialPageRoute(builder: (context) => redirection()),
    // );
      print("edit pressed");
      },
      child:Container(
        alignment: FractionalOffset.topRight,
        margin: new EdgeInsets.only(right: 5.0, top: 5.0),
        child: Icon(
          Icons.edit,
          color: Colors.grey,
          size: 20.0,
        ),
      )
    );
  }
}