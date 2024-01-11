part of 'light_theme.dart';

mixin _LightColors {
  static Color get background => Colors.grey.shade100;

  static Color get white => const Color(0xFFFFFFFF);

  static Color get black => const Color(0xFF000000);

  static Color get blue => Colors.blueAccent;

  static Color get primary => const Color(0xFF1DBF73);

  static Color get primaryVariant => const Color(0xFFE9F9F1);

  static Color get secondary => const Color.fromRGBO(105, 111, 121, 1);

  static Color get secondaryVariant => const Color.fromRGBO(195, 197, 200, 1);

  static Color get error => const Color(0xFFF56242);

  static Color get warning => const Color(0xFFFFCB30);

  static Color get errorField => const Color(0xFFFFF0ED);

  static Color get success => const Color(0xFF2BAC47);

  static Color get successField => const Color(0xFFF9F9F9);

  static Color get gray3 => const Color.fromRGBO(134, 146, 166, 1);

  static Color get textFieldBackgroundColor => const Color(0xFFF9F9F9);
}
