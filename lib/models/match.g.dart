// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) {
  return Match(
    json['id'] as String,
    json['lost'] == null
        ? null
        : Item.fromJson(json['lost'] as Map<String, dynamic>),
    json['found'] == null
        ? null
        : Item.fromJson(json['found'] as Map<String, dynamic>),
    json['status'] as String,
    (json['percentage'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'id': instance.id,
      'lost': instance.lost?.toJson(),
      'found': instance.found?.toJson(),
      'status': instance.status,
      'percentage': instance.percentage,
    };
