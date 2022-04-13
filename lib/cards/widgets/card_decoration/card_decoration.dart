import 'package:flutter/widgets.dart';
import 'boxDecoration_Container.dart';

class CardsFrame extends StatelessWidget {
  final Widget child;

  CardsFrame({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: boxDecorationContainer(),
        constraints: BoxConstraints(minHeight: 400),
        child: child);
  }
}
