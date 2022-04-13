import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class AppBarBuilder extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;

  const AppBarBuilder({Key? key, this.leading, this.actions, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: title,
      flexibleSpace: GradientContainer(),
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class GradientContainer extends StatelessWidget {
  const GradientContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(gradient: gradientColor));
  }
}
