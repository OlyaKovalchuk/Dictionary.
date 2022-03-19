import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';

buildAppBar(
    {Widget? leading,
    List<Widget>? actions,
    Widget? title,
    required BuildContext context}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: title ?? Text('Dictionary.'),
    flexibleSpace: GradientContainer(),
    leading: leading,
    actions: actions,
  );
}

class GradientContainer extends StatelessWidget {
  const GradientContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(gradient: gradientColor));
  }
}
