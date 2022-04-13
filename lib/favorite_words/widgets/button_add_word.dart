import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';
import 'dialog_add_word_builder.dart';

class ButtonAddWord extends StatelessWidget {
  const ButtonAddWord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 85.0),
        child: GestureDetector(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 7,
                      color: Colors.grey,
                      offset: Offset(0, 3)),
                ],
                borderRadius: BorderRadius.circular(30),
                gradient: gradientColor,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            onTap: () {
              showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black26,
                context: context,
                builder: (context) {
                  return DialogAddWordBuilder();
                },
              );
            }));
  }
}
