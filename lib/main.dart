import 'package:Dictionary/blocs/simple_bloc_observer.dart';
import 'package:Dictionary/screens/card_screen.dart';
import 'package:Dictionary/screens/introduction_screen.dart';
import 'package:Dictionary/screens/main_screen.dart';
import 'package:Dictionary/screens/search_screen.dart';
import 'package:Dictionary/service/firebase_auth_service.dart';
import 'package:Dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository _userRepository = UserRepository();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(SplashScreen(
    userRepository: _userRepository,
  ));
}

class SplashScreen extends StatelessWidget {
  final UserRepository _userRepository;

  SplashScreen({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/searchScreen': (BuildContext context) => SearchScreen(),
          '/cardScreen': (BuildContext context) => CardScreen(),
          '/introductionScreen': (BuildContext context) => IntroductionScreen(),
        },
        home: SplashScreenView(
            navigateRoute: HomeScreen(
              userRepository: _userRepository,
            ),
            duration: 3,
            text: 'Dictionary.',
            textStyle: TextStyle(
                fontFamily: ('Futura'), fontSize: 50, color: Colors.white),
            pageRouteTransition: PageRouteTransition.CupertinoPageRoute,
            backgroundColor: gradientColor()));
  }
}
