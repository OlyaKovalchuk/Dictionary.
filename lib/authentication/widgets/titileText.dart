import 'package:flutter/material.dart';

buildTitleText(
        {required String text,
        required double? fontSize,
        FontWeight? fontWeight,
        required BuildContext context}) =>
    Text(
      text,
      style: Theme.of(context)
          .textTheme
          .subtitle2!
          .copyWith(fontSize: fontSize, fontWeight: fontWeight),
    );
