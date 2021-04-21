import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;


class GlobalData {
  static var jwt;
  static String serverAddress = '192.168.0.173:8082';
}

const String authUrl = "35.246.215.234:38777";

Future<String> logIn(LoginData data) async {
  var response =
  await http.post(Uri.http(authUrl, '/login'),
      headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
      body: jsonEncode({"email": data.name, "password": data.password}));
  if (response.statusCode == 200) {
    print("Login success");
    GlobalData.jwt = "Bearer " + jsonDecode(response.body)["token"];
    return null;
  }
  else {
    print("Login failure");
    return "Login failed";
  }
}

Future<String> register(LoginData data) async {
  var response =
  await http.post(Uri.http(authUrl, '/register'),
      headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
      body: jsonEncode({"email": data.name, "password": data.password}));
  if (response.statusCode == 200) {
    print("Register & login success");
    GlobalData.jwt = jsonDecode(response.body)["token"];
    return null;
  }
  else {
    print("Register failure");
    return "Register failure";
  }
}