import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:dio/dio.dart';

class RegisterRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String about;
  final List<num> tags;
  final List<String> favouriteSocialMedia;
  final num salary;
  final String date;
  final bool? gender;
  final num type;
  final File avatar;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.about,
    required this.tags,
    required this.favouriteSocialMedia,
    required this.salary,
    required this.date,
    this.gender,
    required this.type,
    required this.avatar,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'about': about,
      'tags': [tags],
      'favorite_social_media': [favouriteSocialMedia],
      'salary': salary,
      'birth_date': date,
      'type': type,
      'avatar': await MultipartFile.fromFile(
        avatar.path,
        filename: basename(avatar.path),
      ),
    };
  }
}
