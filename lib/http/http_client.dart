 import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HttpClient {
  final client = Client();
  
  Future<Response> get({ required String url, Map<String, String>? headers }) {
    return client.get(Uri.parse(url), headers: headers);

  }
  
}
