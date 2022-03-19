import 'package:Dictionary/cards/widgets/cardDecoration/card_decoration.dart';
import 'package:Dictionary/cards/widgets/cardDecoration/indicator_decoration.dart';
import 'package:flutter/cupertino.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardsFrame(child: indicatorCircular());
  }
}
