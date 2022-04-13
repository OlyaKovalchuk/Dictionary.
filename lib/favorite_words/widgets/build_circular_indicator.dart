import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';

class BuildCircularIndicator extends StatelessWidget {
  const BuildCircularIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: CircularProgressIndicator(color: redColor),
    );
  }
}
