import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class IndicatorCircular extends StatelessWidget {
  const IndicatorCircular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: Center(child: CircularProgressIndicator(color: redColor)));
  }
}

