import 'package:Dictionary/cards/widgets/cardDecoration/card_decoration.dart';
import 'package:Dictionary/cards/widgets/cardDecoration/indicator_decoration.dart';
import 'package:flutter/cupertino.dart';

Widget loadingView(BuildContext context) {
  return cardDecoration(context: context, child: indicatorCircular());
}
