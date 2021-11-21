import 'package:flutter/material.dart';

import 'gradientColor/gradient_widget.dart';

buildAppBar({required Widget? leading, required List<Widget>? actions}) =>
    AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text('Dictionary.',
          style: TextStyle(
              fontFamily: ('Futura'),
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
      flexibleSpace: gradientLinear(),
      leading: leading,
      actions: actions,
    );
