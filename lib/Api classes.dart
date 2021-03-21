import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class Item{
  final String id;
  final String title;
  final String description;
  final String latitude;
  final String longitude;
  final String category;
  final List<String> images;

  Item({this.id, this.title, this.description, this.latitude, this.longitude,
        this.category, this.images});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      category: json['category'],
      images: json['images']
    );
  }
}

Future<Item> fetchLostItems() async {
  // // print(http.get("localhost:8000/category"));
  // // final response = await http.get(Uri.http('localhost:8082/api', 'lost_items'));
  // const String url = 'localhost:8000/api/lost_items/';
  // // var response = await http.get(url);
  // print(response.body)
  // if (response.statusCode == 200) {
  //   // If the server did return a 200 OK response,
  //   // then parse the JSON.
  //   return Item.fromJson(jsonDecode(response.body));
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   throw Exception('Failed to load album');
  // }
}