import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';

Widget buildCircularIndicator() => Container(
      child: indicatorCircular(),
    );

Widget indicatorCircular() => Container(
    height: 400,
    child: Center(child: CircularProgressIndicator(color: redColor)));
