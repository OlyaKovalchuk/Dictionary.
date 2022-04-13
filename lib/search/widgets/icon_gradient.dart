import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class LinearGradientMask extends StatelessWidget {
  LinearGradientMask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) {
          return gradientColor.createShader(bounds);
        },
        child: Icon(
          Icons.search,
          size: 20,
          color: Colors.white,
        ));
  }
}
