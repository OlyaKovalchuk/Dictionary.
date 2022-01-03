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

const colorScheme = ColorScheme(
    background: Colors.white,
    brightness: Brightness.light,
    error: Colors.red,
    secondary: redLightColor,
    secondaryVariant: redLightColor,
    primary: redColor,
    primaryVariant: redLightColor,
    surface: Colors.white,
    onSurface: Colors.grey,
    onSecondary: redLightColor,
    onPrimary: redColor,
    onBackground: redColor,
    onError: Colors.white);