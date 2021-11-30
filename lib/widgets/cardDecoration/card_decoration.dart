import 'package:flutter/widgets.dart';
import 'boxDecoration_Container.dart';

Widget cardDecoration({required Widget child, required BuildContext context}) => Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height/1.8,
    decoration: boxDecorationContainer(),
    child: child);
