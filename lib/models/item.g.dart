// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['id'] as String,
    json['title'] as String,
    json['description'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['category'] as String,
    (json['images'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'category': instance.category,
      'images': instance.images,
    };

Map<String, dynamic> _$ItemToJsonWithoutImages(Item instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'category': instance.category,
};

Map<String, dynamic> _$ItemToJsonWithoutImagesAndID(Item instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'category': instance.category,
};