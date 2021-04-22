import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;


class GlobalData {
  static var jwt;
  static String serverAddress = '10.0.2.2:8082';
  static String uid;
  static bool userExists = false;
}

const String authUrl = "35.246.215.234:38777";

Future<bool> submitUser(
    String email, String name, String nickname, String phone) async {
  var response = await http.post(Uri.http(GlobalData.serverAddress, 'api/users'),
      headers: {
        "Authorization": GlobalData.jwt,
        HttpHeaders.contentTypeHeader: 'application/json'
      },
      body: jsonEncode({
        "email": email,
        "name": name,
        "nickname": nickname,
        "telephone": phone
      }));

  if (response.statusCode == 200) {
    GlobalData.userExists = true;
    return true;
  } else {
    return false;
  }
}

Future<bool> getUser(String uid) async {
  var response = await http.get(Uri.http(GlobalData.serverAddress, 'api/users/$uid'),
      headers: {
        "Authorization": GlobalData.jwt,
      }
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }

}

Future<String> logIn(LoginData data) async {
  var response = await http.post(Uri.http(authUrl, '/login'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({"email": data.name, "password": data.password}));
  if (response.statusCode == 200) {
    print("Login success");
    GlobalData.jwt = "Bearer " + jsonDecode(response.body)["token"];
    GlobalData.uid = data.name;
    getUser(data.name).then((value) => GlobalData.userExists = value);
    return null;
  } else {
    print("Login failure");
    return "Login failed";
  }
}

Future<String> register(LoginData data) async {
  var response = await http.post(Uri.http(authUrl, '/register'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({"email": data.name, "password": data.password}));
  if (response.statusCode == 200) {
    print("Register & login success");
    GlobalData.jwt = "Bearer " + jsonDecode(response.body)["token"];
    GlobalData.uid = data.name;
    return null;
  } else {
    print("Register failure");
    return "Register failure";
  }
}
