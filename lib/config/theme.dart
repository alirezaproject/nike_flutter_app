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
    color: _lightPrimaryColor,
  );

  static final TextStyle _lightDisplayLarge = defaultTextStyle.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle _lightBodyLarge = defaultTextStyle.copyWith();
  static final TextStyle _lightBodySmall = defaultTextStyle.copyWith();

  static final TextTheme _lightTextTheme = TextTheme(displayLarge: _lightDisplayLarge, bodyLarge: _lightBodyLarge, bodySmall: _lightBodySmall);

// ******************
// Icon Colors
// ******************

  // static const Color _iconColor = Colors.white;

  //static const Color _accentColor = Color.fromRGBO(74, 217, 217, 1);

// ******************
// Set Themes
// ******************

  static final ThemeData lightTheme = ThemeData(
      fontFamily: Constants.defaultTextStyle,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: _lightPrimaryColor,
        onPrimary: _lightPrimaryColor,
        secondary: _lightSecondaryColor,
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