import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';

class GradientButtonBuilder extends StatelessWidget {
  final void Function()? onTap;
  final String title;

  GradientButtonBuilder({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 56,
          width: 236,
          decoration: BoxDecoration(
            gradient: gradientColor,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.button,
          ),
        ));
  }
}
