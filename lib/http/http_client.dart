import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Car {
  final int id;
  final String title;
  final String body;

  Car({required this.id, required this.title, required this.body});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
