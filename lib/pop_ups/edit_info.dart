import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lost_and_found_ui/api_requests/items.dart';
import 'package:lost_and_found_ui/api_requests/metadata.dart';
import 'package:lost_and_found_ui/models/item.dart';
import '../text.dart';

class PopUp extends StatefulWidget {
  Item item;

  PopUp(this.item);

  @override
  State<StatefulWidget> createState() => _PopUpState(item);
}

class _PopUpState extends State<PopUp> {
  Item item;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> categories = ["Please select category"];
  String selectedCategory;

  _PopUpState(this.item);

  fetch() {
    fetchCategories().then((value) {
      setState(() {
        categories = value;
        selectedCategory = item.category;
      });
    });
  }

  @override
  initState() {
    super.initState();
    selectedCategory = categories[0];
    titleController.text = item.title;
    descriptionController.text = item.description;
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
              "Informations:",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            contentPadding: EdgeInsets.only(top: 10.0, left: 40, right: 40),
            content: Container(
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
                  TextField(
                    controller: titleController,
                    decoration: new InputDecoration(labelText: 'Title'),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                ],
              ),
            ),
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
                child: Text("Done"),
                onPressed: () {
                  print("SAVING");
                  item.title = titleController.text;
                  item.description = descriptionController.text;
                  item.category = selectedCategory;
                  // updateLostItem(item);
                  Navigator.of(context).pop(item);
                },
              ),
            ],
          ),
        ));
  }
}
