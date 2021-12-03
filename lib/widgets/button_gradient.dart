import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:flutter/material.dart';

buildGradientButton({required void onTap()?, required String title}) =>
    GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 56,
          width: 236,
          decoration: BoxDecoration(
            gradient: gradientColor(),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Text(
            title,
            style: TextStyle(
                fontFamily: ('Futura'),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ));
