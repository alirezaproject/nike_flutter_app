import 'package:flutter/material.dart';
import 'package:nike/core/utils/constants.dart';

class AppTheme {
// ******************
// Light Theme Colors
// ******************

  static const Color _lightPrimaryColor = Color(0xff217CF3);
  static const Color _lightSecondaryColor = Color(0xff262A35);

  static const Color _lightPrimaryTextColor = Color(0xff262A35);
  static const Color _lightSecondaryTextColor = Color(0xffB3B6BE);

// ******************
// Light Theme Fonts
// ******************

  static const defaultTextStyle = TextStyle(
    fontFamily: 'IranYekan',
    color: _lightPrimaryTextColor,
  );

  static final TextStyle _lightDisplayLarge = defaultTextStyle.copyWith(fontWeight: FontWeight.bold);

  static final TextStyle _lightTitleLarge = defaultTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 18);
  static final TextStyle _lightTitleMedium = defaultTextStyle.copyWith(color: _lightSecondaryTextColor);

  static final TextStyle _lightBodyLarge = defaultTextStyle.copyWith();
  static final TextStyle _lightBodyMedium = defaultTextStyle.copyWith();
  static final TextStyle _lightBodySmall = defaultTextStyle.copyWith(color: _lightSecondaryTextColor);

  static final TextStyle _lightLabelSmall = defaultTextStyle.copyWith();
  static final TextStyle _lightLabelMedium = defaultTextStyle.copyWith(color: _lightPrimaryColor);

  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightDisplayLarge,
    titleLarge: _lightTitleLarge,
    titleMedium: _lightTitleMedium,
    bodyLarge: _lightBodyLarge,
    bodyMedium: _lightBodyMedium,
    bodySmall: _lightBodySmall,
    labelSmall: _lightLabelSmall,
    labelMedium: _lightLabelMedium,
  );

// ******************
// Icon Colors
// ******************

  // static const Color _iconColor = Colors.white;

  //static const Color _accentColor = Color.fromRGBO(74, 217, 217, 1);

// ******************
// Set Themes
// ******************

  static final ThemeData lightTheme = ThemeData(
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: defaultTextStyle.copyWith(color: Colors.white),
      ),
      fontFamily: Constants.defaultTextStyle,
      dividerColor: _lightSecondaryColor,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: _lightPrimaryColor,
        onPrimary: Colors.white,
        secondary: _lightSecondaryColor,
        onSecondary: _lightSecondaryTextColor,
        primaryContainer: _lightSecondaryColor,
        onPrimaryContainer: _lightPrimaryColor,
      ),
      textTheme: _lightTextTheme);

  //static ThemeData darkTheme = ThemeData();
}

// ******************
// Dark Theme Colors
// ******************

// static final Color _darkPrimaryColor = Colors.blueGrey.shade900;
// static const Color _darkPrimaryVariantColor = Colors.black;
// static final Color _darkOnPrimaryColor = Colors.blueGrey.shade300;
// static const Color _darkTextColorPrimary = Colors.white;
// static final Color _appbarColorDark = Colors.blueGrey.shade800;

// ******************
// Dark Theme Fonts
// ******************

// static final TextStyle _darkThemeHeadingTextStyle =
//     _lightHeadingText.copyWith(color: _darkTextColorPrimary);

// static final TextStyle _darkThemeBodyeTextStyle =
//     _lightBodyText.copyWith(color: _darkTextColorPrimary);

// static final TextTheme _darkTextTheme = TextTheme(
//   headline1: _darkThemeHeadingTextStyle,
//   bodyText1: _darkThemeBodyeTextStyle,
// );
