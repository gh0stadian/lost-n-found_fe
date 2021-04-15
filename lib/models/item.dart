import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
part 'item.g.dart';

@JsonSerializable(explicitToJson: true)
class Item {
  Item(this.id, this.title, this.description, this.latitude, this.longitude,
      this.category, this.images);

  String id;
  String title;
  String description;
  double latitude;
  double longitude;
  String category;
  List<String> images;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

}

// Item({this.id, this.title, this.description, this.latitude, this.longitude,
//   this.category, this.images});
//
// Item.fromJson(Map<String, dynamic> json)
//     :
//       id = json['id'],
//       title = json['title'],
//       description = json['description'],
//       latitude = json['latitude'],
//       longitude = json['longitude'],
//       category = json['category'],
//       images = json['images'];
//
// Map<String, dynamic> toJson() =>
//     {
//       'id': id,
//       'title': title,
//       'description': description,
//       'latitude': latitude,
//       'longitude': longitude,
//       'category': category,
//       'images': images,
//     };