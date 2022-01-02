import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';

buildGradientButton({required void onTap()?, required String title, required BuildContext context}) =>
    GestureDetector(
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

