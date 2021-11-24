import 'package:flutter/material.dart';

import 'gradientColor/gradient_widget.dart';

buildAppBar({ Widget? leading,  List<Widget>? actions, String? title}) =>
    AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(title ?? 'Dictionary.',
          style: TextStyle(
              fontFamily: ('Futura'),
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
      flexibleSpace: gradientLinear(),
      leading: leading,
      actions: actions,
    );
