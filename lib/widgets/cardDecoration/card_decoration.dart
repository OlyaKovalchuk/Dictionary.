import 'package:flutter/widgets.dart';
import 'boxDecoration_Container.dart';

Widget cardDecoration({required Widget child}) => Container(
    width: double.maxFinite,
    height: 400,
    decoration: boxDecorationContainer(),
    child: child);
