import 'package:flutter/foundation.dart';

class User {
  final String name;
  final String phone;
  final String email;
  final String username;
  final String governorate;
  final String city;

  User({
    required this.name,
    required this.city,
    required this.email,
    required this.governorate,
    required this.phone,
    required this.username,
  });
  User.formjson(Map<String, dynamic> json)
      : name = json['user']['name'],
        phone = json['user']['phone'],
        email = json['user']['email'],
        username = json['user']['username'],
        governorate = json['user']['governorate'],
        city = json['user']['city'];
}
