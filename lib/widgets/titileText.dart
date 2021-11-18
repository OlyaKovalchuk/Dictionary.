import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:flutter/material.dart';

buildTitleText({required String text, required double? fontSize, FontWeight? fontWeight})=>Text(
  text,
  style: TextStyle(
    fontFamily: ('Futura'),
    fontSize: fontSize,
    fontWeight: fontWeight ?? FontWeight.normal,
    foreground: Paint()
      ..shader = gradientColor().createShader(
          Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
  ),
);