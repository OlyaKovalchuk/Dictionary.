import 'package:Dictionary/widgets/cardDecoration/card_decoration.dart';
import 'package:Dictionary/widgets/cardDecoration/indicator_decoration.dart';
import 'package:flutter/cupertino.dart';

Widget loadingView() => Padding(
    padding: EdgeInsets.all(35),
    child: cardDecoration(child: indicatorCircular()));
