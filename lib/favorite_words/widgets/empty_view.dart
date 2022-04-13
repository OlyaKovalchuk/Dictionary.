import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Text(
        "You don't have favorite words yet!",
        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15),
      ),
    );
  }
}
