import 'package:flutter/material.dart';

Container GradientLinear() => Container(
    decoration: BoxDecoration(
        gradient: gradientColor()));

LinearGradient gradientColor() => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromRGBO(223, 78, 80, 1), Color.fromRGBO(234, 117, 92, 1)]);