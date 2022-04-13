import 'package:flutter/material.dart';

class TextTitleBuilder extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;

  TextTitleBuilder(
      {Key? key, required this.text, this.fontWeight, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .subtitle2!
          .copyWith(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
