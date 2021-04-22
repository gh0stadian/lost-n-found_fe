// import 'package:flutter/cupertino.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';

class DetailHeading extends StatelessWidget {
  final String text;

  DetailHeading(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: FractionalOffset.centerLeft,
      margin: new EdgeInsets.only(top: 0, left: 10),
      child: GradientText(
        text: text,
        colors: <Color>[
          Colors.blue,
          Colors.lightBlue.shade900,
        ],
        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class DetailSubtitle extends StatelessWidget {
  final String text;

  DetailSubtitle(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 10.0,
      ),
      alignment: FractionalOffset.topLeft,
      child: new Text(
        text,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}

class Heading extends StatelessWidget {
  final String text;

  Heading(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: FractionalOffset.centerLeft,
      margin: new EdgeInsets.only(top: 40, left: 10),
      child: GradientText(
        text: text,
        colors: <Color>[
          Colors.blue,
          Colors.lightBlue.shade900,
        ],
        style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ItemTitle extends StatelessWidget {
  final String text;

  ItemTitle(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: FractionalOffset.bottomLeft,
      margin: new EdgeInsets.only(left: 20, bottom: 10),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}

Shader linearGradient(double percentage) {
  Color color1;
  Color color2;
  if (percentage > 90) {
    color1 = Color(0xFF76FF03);
    color2 = Color(0xFF00e676);
  } else if (percentage <= 80 && percentage > 60) {
    color1 = Color(0xFF76FF03);
    color2 = Color(0xFFFFEA00);
  } else {
    color1 = Color(0xFFFFEA00);
    color2 = Color(0xFFFF3D00);
  }

  return LinearGradient(
    colors: <Color>[color1, color2],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
}

class MatchPercentage extends StatelessWidget {
  final double percentage;

  MatchPercentage(this.percentage, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: FractionalOffset.topLeft,
      margin: new EdgeInsets.only(left: 10, top: 15),
      child: Text(
        percentage.toStringAsFixed(0) + "% Match",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            foreground: Paint()..shader = linearGradient(percentage)),
      ),
    );
  }
}

class DetailInformation extends StatelessWidget {
  final String brand;
  final String description;
  final String category;
  final String model;

  DetailInformation(this.brand, this.description, this.category, this.model,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      // alignment: FractionalOffset.left,
      margin: new EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        children: [
          DetailInformationRow("category:", category),
          SizedBox(height: 15),
          DetailInformationRow("brand:", brand),
          SizedBox(height: 15),
          DetailInformationRow("model:", model),
          SizedBox(height: 15),
          DetailInformationRow("description:", description),
        ],
      ),
    );
  }
}

class DetailInformationRow extends StatelessWidget {
  final String key_value;
  final String value;

  DetailInformationRow(this.key_value, this.value, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // alignment: WrapAlignment.spaceAround, // set your alignment
      // spacing: 100,
      children: [
        Expanded(
            child: Text(
          key_value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        )),
        // Spacer(),
        Flexible(
            child: Text(value,
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
                maxLines: 3))
      ],
    ));
  }
}
