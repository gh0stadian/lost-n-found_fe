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
  String latitude;
  String longitude;
  String category;
  List<String> images;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
  Map<String, dynamic> toJsonWithoutImages() => _$ItemToJson(this);

}