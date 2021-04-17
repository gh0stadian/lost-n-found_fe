import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/match.dart';

Future<List<Match>> fetchMatches() async {
  String url = 'api/items/matches';
  var response =
  await http.get(Uri.http('10.0.2.2:8082', url), headers: {
    'Authorization':
    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRlc3RfdXNlcjJ'
        'AZW1haWwuY29tIn0.WSMhA8rUyCYvufxG174DkAsGCUMSyqaZjZXun9tki0M'
  });
  if (response.statusCode == 200) {
    // print(response.body);
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Match> matches = [];
    Map decoded = jsonDecode(response.body);
    for (var match in decoded["matches"]) {
      Match match_obj = Match.fromJson(match);
      matches.add(match_obj);
    }
    String itemname = matches[0].id;

    print("ID of the match is $itemname");
    return matches;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}