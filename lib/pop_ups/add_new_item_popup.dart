import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lost_and_found_ui/api_requests/items.dart';
import 'package:lost_and_found_ui/api_requests/metadata.dart';
import 'package:lost_and_found_ui/models/item.dart';
import '../text.dart';
import 'edit_photos.dart';

class createItemPopUp extends StatefulWidget {
  String itemType;

  createItemPopUp(this.itemType);

  @override
  State<StatefulWidget> createState() => _createItemPopUpState();
}

class _createItemPopUpState extends State<createItemPopUp> {
  Item item = new Item("1", "1", "1", 10, 10, "Wallet", []);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> categories = ["Please select category"];
  String selectedCategory;
  final _formKey = GlobalKey<FormState>();

  fetch() {
    fetchCategories().then((value) {
      setState(() {
        categories = value;
        selectedCategory = categories[0];
      });
    });
  }

  @override
  initState() {
    super.initState();
    selectedCategory = categories[0];
    fetch();
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
              "Information:",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            contentPadding: EdgeInsets.only(top: 10.0, left: 40, right: 40),
            content: Form(
                key: _formKey,
                child: Container(
                  width: 400,
                  height: 290,
                  child: ListView(
                    children: [
                      SizedBox(height: 10),
                      DropdownButton<String>(
                        value: selectedCategory,
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: SizedBox(
                              width: 225.0,
                              child: Text(category),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        },
                      ),
                      TextFormField(
                        controller: titleController,
                        decoration: new InputDecoration(labelText: 'Title'),
                        validator: (value) {
                          if (value == "") {
                            return "You need to input title";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(labelText: 'Description'),
                        validator: (value) {
                          if (value == "") {
                            return "You need to input description";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Back"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                elevation: 5.0,
                child: Text("Next"),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    print("SAVING");
                    item.title = titleController.text;
                    item.description = descriptionController.text;
                    item.category = selectedCategory;
                    createItem(item, widget.itemType).then((value) {
                      item = value;
                      Navigator.of(context).push(DialogRoute(
                          context: context,
                          builder: (BuildContext context) =>
                              editPhotosPopUp(item, widget.itemType, true)));
                    });
                  }
                },
              ),
            ],
          ),
        ));
  }
}
