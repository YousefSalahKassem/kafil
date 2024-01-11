import 'package:kafil/features/countries/models/pagination.dart';

class CountryModel {
  final List<Country> countries;
  final Pagination pagination;

  CountryModel({
    required this.countries,
    required this.pagination,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      countries: (json['data'] as List)
          .map((countryJson) => Country.fromJson(countryJson))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Country {
  final int id;
  final String countryCode;
  final String name;
  final String capital;

  Country({
    required this.id,
    required this.countryCode,
    required this.name,
    required this.capital,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'] as int,
      countryCode: json['country_code'] as String,
      name: json['name'] as String,
      capital: json['capital'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country_code': countryCode,
      'name': name,
      'capital': capital,
    };
  }
}
