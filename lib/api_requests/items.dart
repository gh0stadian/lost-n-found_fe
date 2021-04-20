import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/item.dart';

Future<List<Item>> fetchItems(String itemType) async {
  String url = 'api/items/'+ itemType;
  var response =
      await http.get(Uri.http('10.0.2.2:8082', url), headers: {
    'Authorization':
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRlc3RfdXNlcjJ'
            'AZW1haWwuY29tIn0.WSMhA8rUyCYvufxG174DkAsGCUMSyqaZjZXun9tki0M'
  });
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

Future<int> updateItem(Item item, String itemType) async {
  String route = 'api/items/'+ itemType + '/' + item.id;
  var response =
      await http.patch(Uri.http('10.0.2.2:8082', route),
          headers: {
            'Authorization':
                'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRlc3'
                    'RfdXNlcjJAZW1haWwuY29tIn0.WSMhA8rUyCYvufxG174DkAsGCUMSyqaZ'
                    'jZXun9tki0M',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body:
              json.encode(item.toJsonWithoutImages()),
          );
  if (response.statusCode == 200) {
    print("UPDATE OK");
    return 0;
  } else {
    print("UPDATE FAILED");
    return 1;
  }
}

