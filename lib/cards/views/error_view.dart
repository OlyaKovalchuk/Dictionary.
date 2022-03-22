import 'package:flutter/cupertino.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Oops... Something went wrong!  :('),
    );
  }
}
