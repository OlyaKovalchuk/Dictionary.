import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:flutter/material.dart';

Widget titleWord(String partOfSpeech)=> Container(
    alignment: Alignment.centerLeft,
    height: 30,
    width: double.infinity,
    color: Color.fromRGBO(247, 247, 247, 1),
    child: Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Text(
       partOfSpeech,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: ('Futura'),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          foreground: Paint()
            ..shader = gradientColor().createShader(
                Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
        ),
      ),
    ));