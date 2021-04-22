import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/item.dart';
import '../auth.dart';

Future<List<Item>> userItems(String itemType) async {
  String url = 'api/items/' + itemType;
  var response = await http.get(Uri.http(GlobalData.serverAddress, url),
      headers: {'Authorization': GlobalData.jwt});
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Item> items = [];
    Map decoded = jsonDecode(response.body);
    for (var item in decoded["items"]) {
      Item item_obj = Item.fromJson(item);
      items.add(item_obj);
    }
    String itemname = items[0].id;

    print("ID of the item is $itemname");
    return items;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
