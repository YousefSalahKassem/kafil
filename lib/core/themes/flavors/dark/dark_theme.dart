import 'package:flutter/material.dart';
import 'package:kafil/core/themes/app_sizes.dart';
import 'package:kafil/core/themes/app_text_styles.dart';
import 'package:kafil/core/themes/app_theme_flavor.dart';
import 'package:kafil/core/themes/data.dart';
import 'package:kafil/core/utilities/extensions.dart';

part 'dark_color.dart';

class DarkTheme extends AppThemeFlavor {
  DarkTheme() : super.init();

  @override
  ThemeData createThemeData(BuildContext context) {
    final appSizes = context.isTablet ? AppSizes.tablet() : AppSizes.mobile();
    final appTextStyle =
        context.isTablet ? AppTextStyles.tablet() : AppTextStyles.mobile();

    final textTheme = appTextStyle.toTextTheme().apply(
          fontFamily: 'Montserrat',
          displayColor: _DarkColors.white,
          bodyColor: _DarkColors.white,
          decorationColor: _DarkColors.white,
        );
    return ThemeData.from(colorScheme: ColorScheme.fromSwatch()).copyWith(
      scaffoldBackgroundColor: _DarkColors.white,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        color: _DarkColors.black,
        foregroundColor: _DarkColors.white,
        elevation: 0,
      ),
      tabBarTheme: TabBarTheme(
        indicatorColor: _DarkColors.white,
        labelColor: _DarkColors.white,
      ),
      dividerColor: _DarkColors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _DarkColors.blue,
          foregroundColor: _DarkColors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle:
            context.textTheme.bodyMedium!.copyWith(color: _DarkColors.white),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white38,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white38,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white38,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white38,
          ),
        ),
      ),
      extensions: [
        appTextStyle,
        appSizes,
        AppThemeData(
          white: _DarkColors.white,
          black: _DarkColors.black,
          blue: _DarkColors.blue,
          primary: _DarkColors.primary,
          primaryVariant: _DarkColors.primaryVariant,
          secondary: _DarkColors.secondary,
          secondaryVariant: _DarkColors.secondaryVariant,
          error: _DarkColors.error,
          errorField: _DarkColors.errorField,
          success: _DarkColors.success,
          warning: _DarkColors.success,
          successField: _DarkColors.successField,
          gray3: _DarkColors.gray3,
          background: _DarkColors.background,
        ),
      ],
    );
  }

  @override
  Brightness get windowBrightness => Brightness.dark;
}
