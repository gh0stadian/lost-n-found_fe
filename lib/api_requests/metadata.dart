import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<String>> fetchCategories() async {
  var response = await http.get(Uri.http('10.0.2.2:8082', 'api/metadata'), headers: {'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRlc3RfdXNlcjJAZW1haWwuY29tIn0.WSMhA8rUyCYvufxG174DkAsGCUMSyqaZjZXun9tki0M'});
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