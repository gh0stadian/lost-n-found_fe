import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/match.dart';
import '../auth.dart';

Future<List<Match>> fetchMatches() async {
  String url = 'api/items/matches';
  var response = await http.get(Uri.http(GlobalData.serverAddress, url),
      headers: {'Authorization': GlobalData.jwt});
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

    return matches;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<int> updateMatch(Match match) async {
  String route = 'api/items/matches/' + match.id;
  var response = await http.patch(
    Uri.http(GlobalData.serverAddress, route),
    headers: {
      'Authorization': GlobalData.jwt,
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    body: json.encode(match.toJson()),
  );
  if (response.statusCode == 200) {
    print("UPDATE OK");
    return 0;
  } else {
    print("UPDATE FAILED");
    return 1;
  }
}