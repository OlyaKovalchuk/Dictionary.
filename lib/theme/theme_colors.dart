import 'package:flutter/material.dart';

const Color greyDarkColor = Color.fromRGBO(91, 91, 91, 1);
const Color greyColor = Color.fromRGBO(151, 151, 151, 1);
const Color greyLightColor = Color.fromRGBO(223, 223, 223, 1);
const Color greyToWhite = Color.fromRGBO(247, 247, 247, 1);
const Color redColor = Color.fromRGBO(223, 78, 80, 1);
const Color redLightColor = Color.fromRGBO(234, 117, 92, 1);

const LinearGradient gradientColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [redColor, redLightColor]);

Paint gradientTextColor = Paint()
  ..shader = gradientColor.createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

const colorScheme = ColorScheme(
    background: greyToWhite,
    brightness: Brightness.light,
    error: redColor,
    secondary: redLightColor,
    secondaryVariant: redLightColor,
    primary: redColor,
    primaryVariant: redLightColor,
    surface: greyToWhite,
    onSurface: greyColor,
    onSecondary: redLightColor,
    onPrimary: redColor,
    onBackground: redColor,
    onError: redLightColor);
