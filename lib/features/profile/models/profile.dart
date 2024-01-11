import 'package:kafil/features/authentication/models/app_dependencies.dart';

class Profile {
  final String firstName;
  final String lastName;
  final String email;
  final String about;
  final List<Dependency> tags;
  final List<String> favouriteSocialMedia;
  final num salary;
  final String date;
  final num? gender;
  final num type;
  final String avatar;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.about,
    required this.tags,
    required this.favouriteSocialMedia,
    required this.salary,
    required this.date,
    this.gender,
    required this.type,
    required this.avatar,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      about: json['about'] as String,
      tags: (json['tags'] as List)
          .map(
              (tagJson) => Dependency.fromJson(tagJson as Map<String, dynamic>))
          .toList(),
      favouriteSocialMedia: List<String>.from(json['favorite_social_media']),
      salary: json['salary'] as num,
      date: json['birth_date'] as String,
      gender: json['gender'] as num?,
      type: json['type'] as num,
      avatar: json['avatar'] as String,
    );
  }
}
