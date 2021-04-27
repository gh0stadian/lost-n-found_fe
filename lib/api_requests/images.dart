import 'dart:ffi';
import 'dart:typed_data';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import '../models/item.dart';
import '../auth.dart';

Future<int> uploadImage(Uint8List image, String id) async {
  String url = 'api/files/upload/' + id;

  var dioRequest = dio.Dio();
  dioRequest.options.headers = {
    'Authorization': GlobalData.jwt,
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var file = await dio.MultipartFile.fromBytes(image,
      filename: "jpg");

  var formData = dio.FormData();
  formData.files.add(MapEntry("file", file));

  var response = await dioRequest.put(
    "http://" + GlobalData.serverAddress + "/" + url,
    data: formData,
  );

  if (response.statusCode == 200) {
    print("UPLOAD OK");
    return 1;
  } else {
    print("UPLOAD FAIL");
    return 0;
  }
}
