import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafil/core/themes/app_sizes.dart';
import 'package:kafil/core/themes/app_text_styles.dart';
import 'package:kafil/core/themes/app_theme_flavor.dart';
import 'package:kafil/core/themes/data.dart';
import 'package:kafil/core/utilities/extensions.dart';

part 'light_color.dart';

class LightTheme extends AppThemeFlavor {
  LightTheme() : super.init();

  @override
  ThemeData createThemeData(BuildContext context) {
    final appSizes = context.isTablet ? AppSizes.tablet() : AppSizes.mobile();
    final appTextStyle =
        context.isTablet ? AppTextStyles.tablet() : AppTextStyles.mobile();

    final textTheme = appTextStyle.toTextTheme().apply(
          fontFamily: 'Montserrat',
          displayColor: _LightColors.secondary,
          bodyColor: _LightColors.secondary,
          decorationColor: _LightColors.secondary,
        );
    return ThemeData.from(colorScheme: ColorScheme.fromSwatch()).copyWith(
      scaffoldBackgroundColor: _LightColors.background,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        foregroundColor: _LightColors.black,
        surfaceTintColor: _LightColors.white,
        backgroundColor: _LightColors.background,
        toolbarHeight: 120.h,
        titleSpacing: 0,
        titleTextStyle: appTextStyle.subheadLarge.copyWith(
          color: _LightColors.black,
        ),
      ),
      dividerColor: Colors.grey.shade100,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _LightColors.primary,
          foregroundColor: _LightColors.white,
          textStyle: appTextStyle.bodyMedium,
          padding: EdgeInsets.symmetric(vertical: 20.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(_LightColors.white),
        checkColor: MaterialStateProperty.all<Color>(_LightColors.white),
        overlayColor: MaterialStateProperty.all<Color>(
          _LightColors.white,
        ),
        side: BorderSide(
          color: _LightColors.secondaryVariant,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _LightColors.background,
        unselectedItemColor: _LightColors.secondaryVariant,
        selectedItemColor: _LightColors.primary,
        enableFeedback: false,
        elevation: 1,
      ),
      cardTheme: CardTheme(
        color: _LightColors.white,
        surfaceTintColor: _LightColors.white,
        elevation: 0,
      ),
      iconTheme: IconThemeData(
        color: _LightColors.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _LightColors.textFieldBackgroundColor,
        suffixIconColor: _LightColors.gray3,
        labelStyle: appTextStyle.subheadSmall,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      extensions: [
        appTextStyle,
        appSizes,
        AppThemeData(
          white: _LightColors.white,
          black: _LightColors.black,
          blue: _LightColors.blue,
          primary: _LightColors.primary,
          primaryVariant: _LightColors.primaryVariant,
          secondary: _LightColors.secondary,
          secondaryVariant: _LightColors.secondaryVariant,
          error: _LightColors.error,
          errorField: _LightColors.errorField,
          success: _LightColors.success,
          successField: _LightColors.successField,
          gray3: _LightColors.gray3,
          warning: _LightColors.warning,
          background: _LightColors.background,
        ),
      ],
    );
  }

  @override
  Brightness get windowBrightness => Brightness.dark;
}
