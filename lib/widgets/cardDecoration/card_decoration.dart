import 'package:flutter/widgets.dart';
import 'boxDecoration_Container.dart';

Widget cardDecoration({required Widget child, required BuildContext context}) => Container(
    width: double.maxFinite,
    height: MediaQuery.of(context).size.width,
    decoration: boxDecorationContainer(),
    child: child);
