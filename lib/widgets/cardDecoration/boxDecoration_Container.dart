import 'package:flutter/material.dart';

BoxDecoration BoxDecoration_Container() => BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(209, 209, 209, 0.5),
        spreadRadius: 0,
        blurRadius: 16,
        offset: Offset(0, 4), // changes position of shadow
      ),
    ],
    borderRadius: BorderRadius.circular(16.0),
    border: Border.all(color: Colors.white));
