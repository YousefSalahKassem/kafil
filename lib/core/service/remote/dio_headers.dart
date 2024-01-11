import 'dart:io';

mixin DioHeaders {
  static Map<String, String> headersWithNewToken(
    String? authToken,
  ) {
    return {
      "Authorization": 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };
  }

  static Map<String, String> jsonHeaders() => {
        "x-api-version": '1',
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
      };

  static Map<String, String> formHeaders() => {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
        HttpHeaders.acceptHeader: "application/json",
        "Accept-Language": "ar",
      };

  static Map<String, String> multipartHeaders() => {
        HttpHeaders.contentTypeHeader: "multipart/form-data",
        HttpHeaders.acceptHeader: "application/json",
        "Accept-Language": "ar",
      };

  static Map<String, String> headersWithTokenAndLanguage(
    String? authToken,
    String? language,
  ) =>
      {
        "Authorization": 'Bearer $authToken',
        "x-api-version": '1',
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        "Accept-Language": language ?? "en",
      };

  static Map<String, String> headersWithLanguage(String? language) => {
        "x-api-version": '1',
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        "Accept-Language": language ?? "en",
      };
}
