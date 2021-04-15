import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/item.dart';

Future<List<Item>> fetchLostItems() async {
  var response = await http.get(Uri.http('192.168.12.26:8082', 'api/items/lost'), headers: {'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRlc3RfdXNlcjJAZW1haWwuY29tIn0.WSMhA8rUyCYvufxG174DkAsGCUMSyqaZjZXun9tki0M'});
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