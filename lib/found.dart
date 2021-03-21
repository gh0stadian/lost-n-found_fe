import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Api classes.dart';
// import 'text.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: new Column(
            children: <Widget>[
              Heading(),
              new PlanetRow(),
              new PlanetRow(),
              new PlanetRow(),
            ],
          ),
        ),
    );
  }
}

class PlanetRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 250.0,
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        child: new Stack(
          children: <Widget>[
            planetCard,
            planetThumbnail,
            title,
          ],
        )
    );
  }
}

final planetCard = new Container(
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
        offset: new Offset(0.0, 20.0),
      ),
    ],
  ),
);

final planetThumbnail = new Container(
  margin: new EdgeInsets.symmetric(
      vertical: 0.0
  ),
  alignment: FractionalOffset.topCenter,
  child: new Image(
    image: new AssetImage("assets/img/flower.jpg"),
    height: 200.0,
    // width: BoxFit.fitWidth,
    // fit: BoxFit.fitWidth,
    // width: 92.0,
  ),
);

final title = new Container(
  alignment: FractionalOffset.bottomLeft,
  margin: new EdgeInsets.only(left: 20, bottom: 10),
  child: Text(
    "This is item title",
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  ),
);

class Heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: FractionalOffset.centerLeft,
      margin: new EdgeInsets.only(top: 40, left: 10),
      child: GradientText(
        text: 'Lost items',
        colors: <Color>[
          Colors.blue,
          Colors.lightBlue.shade900,
        ],
        style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
