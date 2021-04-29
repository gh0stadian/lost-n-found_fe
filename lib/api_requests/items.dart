import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/item.dart';
import '../auth.dart';

Future<List<Item>> fetchItems(String itemType) async {
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
    return items;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<int> updateItem(Item item, String itemType) async {
  String route = 'api/items/' + itemType + '/' + item.id;
  var response = await http.patch(
    Uri.http(GlobalData.serverAddress, route),
    headers: {
      'Authorization': GlobalData.jwt,
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    body: json.encode(item.toJsonWithoutImages()),
  );
  if (response.statusCode == 200) {
    print("UPDATE OK");
    return 0;
  } else {
    print("UPDATE FAILED");
    return 1;
  }
}

Future<Item> createItem(Item item, String itemType) async {
  item.latitude = 10;
  item.longitude = 10;
  String route = 'api/items/' + itemType;
  print(item.toJson());
  var response = await http.post(
    Uri.http(GlobalData.serverAddress, route),
    headers: {
      'Authorization': GlobalData.jwt,
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    body: json.encode(item.toJsonWithoutImagesAndID()),
  );

  Map decoded = jsonDecode(response.body);
  Item item_obj = Item.fromJson(decoded);

  if (response.statusCode == 200) {
    print("UPDATE OK");
    return item_obj;
  } else {
    print(response.statusCode);
    print("UPDATE FAILED");
    return null;
  }
}

Future<int> deleteItem(Item item, String itemType) async {
  String route = 'api/items/' + itemType + '/' + item.id;
  var response = await http.delete(
    Uri.http(GlobalData.serverAddress, route),
    headers: {
      'Authorization': GlobalData.jwt,
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );
  if (response.statusCode == 200) {
    print("DELETED");
    return 0;
  } else {
    print("DELETE FAILED");
    return 1;
  }
}