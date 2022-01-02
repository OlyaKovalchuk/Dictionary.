import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';


buildAppBar({ Widget? leading,  List<Widget>? actions, Widget? title, required BuildContext context}) {
      return AppBar(
            automaticallyImplyLeading: false,
            title: title ?? Text('Dictionary.'),
            flexibleSpace: _gradientLinear(),
            leading: leading,
            actions: actions,
      );
}


Container _gradientLinear() =>
    Container(decoration: BoxDecoration(gradient: gradientColor));