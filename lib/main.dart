import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:Dictionary/views/dictionary.home.dart';
import 'package:Dictionary/views/search_view.dart';
import 'package:Dictionary/views/start_view.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/search': (BuildContext context) => new SearchPage(),
        '/dictionary': (BuildContext context) => DictionaryHome(),
        '/start': (BuildContext context) => StartView(),
      },
      home:  SplashScreenView(
      navigateRoute:DictionaryHome(),
      duration: 3,
      text:
      'Dictionary',
      textStyle: TextStyle(
          fontFamily: ('Futura'),
          fontSize: 50,
          color: Colors.white),
      pageRouteTransition: PageRouteTransition.CupertinoPageRoute,
      backgroundColor: gradientColor()
  )));
}
