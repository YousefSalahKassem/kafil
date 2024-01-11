mixin DioExtra {
  static Map<String, dynamic> isTokenRequired({
    required bool isTokenRequired,
  }) =>
      {
        "requireToken": isTokenRequired,
      };
}
