import 'package:flutter/material.dart';

/*
Custom extension for appTheme to add all customizations for specific components inside this class.

For example:
If there is custom widget you need to specific color for it in light and dark mode.
You can easily call it with this extension from context by calling: 'context.appTheme.blue'
*/

typedef AppThemeExtension = ThemeExtension<AppThemeData>;

class AppThemeData extends AppThemeExtension {
  final Color black;
  final Color white;
  final Color blue;
  final Color primary;
  final Color primaryVariant;
  final Color secondary;
  final Color secondaryVariant;
  final Color error;
  final Color errorField;
  final Color success;
  final Color successField;
  final Color gray3;
  final Color background;
  final Color warning;

  const AppThemeData({
    required this.white,
    required this.black,
    required this.blue,
    required this.primary,
    required this.primaryVariant,
    required this.secondary,
    required this.secondaryVariant,
    required this.error,
    required this.errorField,
    required this.success,
    required this.successField,
    required this.gray3,
    required this.background,
    required this.warning,
  });

  @override
  ThemeExtension<AppThemeData> copyWith() {
    return this;
  }

  /*
  The 'lerp' method is used to linearly interpolate between two  instances.
  It takes in another  instance 'other' and a double 't' which represents
  The interpolation fraction.

  Overall, it's facilitating the blending of instance based on the linear interpolation of their properties.
  Allowing for smooth transitions or transformations between two instances.
   */

  @override
  AppThemeExtension lerp(AppThemeExtension? other, double t) {
    if (other is! AppThemeData) return this;

    final normT = t.clamp(0, 1).toDouble();
    Color lerpColor(Color color1, Color color2) {
      return Color.lerp(color1, color2, normT)!;
    }

    return AppThemeData(
      black: lerpColor(black, other.black),
      white: lerpColor(white, other.white),
      blue: lerpColor(blue, other.blue),
      primary: lerpColor(primary, other.primary),
      primaryVariant: lerpColor(primaryVariant, other.primaryVariant),
      secondary: lerpColor(secondary, other.secondary),
      secondaryVariant: lerpColor(secondaryVariant, other.secondaryVariant),
      error: lerpColor(error, other.error),
      errorField: lerpColor(errorField, other.errorField),
      successField: lerpColor(successField, other.successField),
      success: lerpColor(success, other.success),
      gray3: lerpColor(gray3, other.gray3),
      background: lerpColor(background, other.background),
      warning: lerpColor(warning, other.warning),
    );
  }

  List<Object?> get props => [
        black,
        white,
        blue,
        primary,
        primaryVariant,
        secondary,
        secondaryVariant,
        error,
        success,
        gray3,
        background,
        errorField,
        successField,
        warning,
      ];
}
