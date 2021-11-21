import 'package:dictionary/simple_bloc_observer.dart';
import 'package:dictionary/authentication/screens/login_screen.dart';
import 'package:dictionary/authentication/screens/register_screen.dart';
import 'package:dictionary/cards/screen/card_screen.dart';
import 'package:dictionary/authentication/screens/auth_screen.dart';
import 'package:dictionary/authentication/screens/main_screen.dart';
import 'package:dictionary/search/search_screen.dart';
import 'package:dictionary/authentication/service/firebase_auth_service.dart';
import 'package:dictionary/widgets/gradientColor/gradient_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final UserRepositoryImpl _userRepository = UserRepositoryImpl();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(SplashScreen(
    userRepository: _userRepository,
  ));
}

class SplashScreen extends StatelessWidget {
  final UserRepositoryImpl _userRepository;

  SplashScreen({required UserRepositoryImpl userRepository})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/searchScreen': (BuildContext context) => SearchScreen(),
          '/cardScreen': (BuildContext context) => CardScreen(),
          '/introductionScreen': (BuildContext context) => IntroductionScreen(),
          '/registerScreen': (BuildContext context) => RegisterScreen(),
          '/loginScreen': (BuildContext context) => LoginScreen(
                userRepository: _userRepository,
              )
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
