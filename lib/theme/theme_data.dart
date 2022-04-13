import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  colorScheme: colorScheme,
  fontFamily: 'Futura',
  appBarTheme: _appBarTheme,
  textTheme: _textTheme,
);

final TextTheme _textTheme = TextTheme(
  //cards
  subtitle1: TextStyle(fontSize: 35, color: greyDarkColor),
  // word
  subtitle2: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    foreground: gradientTextColor,
  ),
  bodyText1: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 15,
      color: greyDarkColor,
      fontWeight: FontWeight.normal),
  bodyText2:
      TextStyle(color: greyColor, fontSize: 15, fontWeight: FontWeight.bold),
  button:
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
);

const AppBarTheme _appBarTheme = AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(
        fontFamily: 'Futura',
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white));
