import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';

import 'general_widgets.dart';

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
            new Heading(),
            new PhotoRow(),
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
            Subtitle,
            SampleImage,
          ],
        ));
  }
}

final SampleImage = new Container(
  margin: new EdgeInsets.symmetric(vertical: 10.0),
  alignment: FractionalOffset.center,
  child: new Image(
    image: new AssetImage("assets/img/flower.jpg"),
    height: 200.0,
    // width: BoxFit.fitWidth,
    // fit: BoxFit.fitWidth,
    // width: 92.0,
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

class Heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: FractionalOffset.centerLeft,
      margin: new EdgeInsets.only(top: 0, left: 10),
      child: GradientText(
        text: 'Lost item title',
        colors: <Color>[
          Colors.blue,
          Colors.lightBlue.shade900,
        ],
        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}

final Subtitle = new Container(
  margin: const EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 10.0,
  ),
  alignment: FractionalOffset.topLeft,
  child: new Text(
    'Photos:',
    style: TextStyle(color: Colors.grey),
  ),
);
