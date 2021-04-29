import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found_ui/api_requests/images.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:load/load.dart';

import 'package:lost_and_found_ui/api_requests/items.dart';
import 'package:lost_and_found_ui/api_requests/metadata.dart';
import 'package:lost_and_found_ui/models/item.dart';
import "location_picker.dart";
import '../text.dart';

class editPhotosPopUp extends StatefulWidget {
  Item item;
  String itemType;
  bool isNew;

  editPhotosPopUp(this.item, this.itemType, this.isNew);

  @override
  State<StatefulWidget> createState() => _editPhotosPopUpState();
}

class _editPhotosPopUpState extends State<editPhotosPopUp> {
  List<Asset> images = <Asset>[];

  Future loadImages() async {
    List<Asset> resultList = <Asset>[];

    try {
      resultList = await MultiImagePicker.pickImages(
        enableCamera: true,
        maxImages: 6,
        selectedAssets: images,
      );
    } on Exception catch (e) {
      print(e.toString());
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  persistImages() {
    print("UPLOADING");
    for (var image in images) {
      image.getByteData().then((value) {
        var bytes = value.buffer.asUint8List();
        showLoadingDialog();
        uploadImage(bytes, widget.item.id).then((value) => hideLoadingDialog());
      });
    }
  }

  getActions() {
    if (widget.isNew) {
      return <Widget>[
        MaterialButton(
          elevation: 5.0,
          child: Text("Next"),
          onPressed: () {
            persistImages();
            Navigator.of(context).push(DialogRoute(
                context: context,
                builder: (BuildContext context) =>
                    LocationPickerPopup(widget.item, widget.itemType)));
          },
        ),
      ];
    }
    else {
      return <Widget>[
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
            persistImages();
            Navigator.pop(context);
          },
        ),
      ];
    }
  }

  @override
  initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 600,
          height: 300,
        );
      }),
    );
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
              "Photos:",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            contentPadding: EdgeInsets.only(left: 40, right: 40),
            content: Container(
                width: 400,
                height: 250,
                child: Column(
                  children: [
                    Expanded(
                      child: buildGridView(),
                    ),
                    MaterialButton(
                      elevation: 5.0,
                      minWidth: 300,
                      height: 40,
                      color: Colors.blue.shade600,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add_a_photo,
                            color: Colors.black,
                          ),
                          SizedBox(width: 65),
                          Text(
                            "Upload",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      onPressed: loadImages,
                    ),
                  ],
                )),
            actions: this.getActions(),
          ),
        ));
  }
}
