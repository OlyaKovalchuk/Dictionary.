import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:Dictionary/screens/card_screen.dart';
import 'package:Dictionary/screens/search_screen.dart';
import 'package:Dictionary/screens/introduction_screen.dart';
import 'package:flutter/services.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/searchScreen': (BuildContext context) => new SearchScreen(),
        '/cardScreen': (BuildContext context) => CardScreen(),
        '/introductionScreen': (BuildContext context) => IntroductionScreen(),
      },
      home:  SplashScreenView(
      navigateRoute: IntroductionScreen() ,
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
