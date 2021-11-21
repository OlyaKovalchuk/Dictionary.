import 'package:dictionary/widgets/cardDecoration/card_decoration.dart';
import 'package:dictionary/widgets/cardDecoration/indicator_decoration.dart';
import 'package:flutter/cupertino.dart';

Widget loadingView(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(35),
    child: cardDecoration( context: context,child: indicatorCircular()));}
