import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../auth.dart';

Future<List<String>> fetchCategories() async {
  var response = await http.get(
      Uri.http(GlobalData.serverAddress, 'api/metadata'),
      headers: {'Authorization': GlobalData.jwt});
  if (response.statusCode == 200) {
    List<String> categories = [];
    Map decoded = jsonDecode(response.body);
    for (var category in decoded["categories"]) {
      categories.add(category);
    }
    return categories;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
