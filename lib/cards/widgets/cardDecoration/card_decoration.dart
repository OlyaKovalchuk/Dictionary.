import 'package:flutter/widgets.dart';
import 'boxDecoration_Container.dart';

Widget cardDecoration({required Widget child, required BuildContext context}) =>
    Container(
        decoration: boxDecorationContainer(),
        constraints: BoxConstraints(minHeight: 400),
        child: child);
