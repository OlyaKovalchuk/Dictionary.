import 'package:flutter/material.dart';

errorOutput({required String error, required BuildContext context}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    width: 300,
    content: Text(
      error,
      style: TextStyle(color: Theme.of(context).colorScheme.surface),
      softWrap: true,
      textAlign: TextAlign.center,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        side: BorderSide.none),
    backgroundColor: Theme.of(context).colorScheme.primary,
    elevation: 0,
  ));
}
