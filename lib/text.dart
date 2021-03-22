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

class DetailInformation extends StatelessWidget {
  final String brand;
  final String description;
  final String category;
  final String model;

  DetailInformation(
      this.brand,
      this.description,
      this.category,
      this.model,
      {Key key}) : super(key: key);

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

  DetailInformationRow(
      this.key_value,
      this.value,
      {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // alignment: WrapAlignment.spaceAround, // set your alignment
      // spacing: 100,
      children: [
        Text(
          key_value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 20),
        )
      ],
    );
  }
}