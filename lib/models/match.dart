import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

import 'item.dart';
part 'match.g.dart';

@JsonSerializable(explicitToJson: true)
class Match {
  Match(this.id, this.lost, this.found, this.status, this.percentage);

  String id;
  Item lost;
  Item found;
  String status;
  double percentage;

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);

  Map<String, dynamic> toJson() => _$MatchToJson(this);
}