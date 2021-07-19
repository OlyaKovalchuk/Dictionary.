import 'package:flutter/material.dart';

class LinearGradientMask extends StatelessWidget {
  LinearGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return RadialGradient(
          center: Alignment.topLeft,
          radius: 1,
          colors: [
            Color.fromRGBO(223, 78, 80, 1),
            Color.fromRGBO(234, 117, 92, 1)
          ],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
Widget Icon_Gradient() => LinearGradientMask(
    child: Icon(
      Icons.search,
      size: 20,
      color: Colors.white,
    ));