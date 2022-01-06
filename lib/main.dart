import 'package:Dictionary/cards/repository/word_data.dart';
import 'package:Dictionary/favorite_words/bloc/favorite_words_bloc.dart';
import 'package:Dictionary/favorite_words/service/favorite_words_service.dart';
import 'package:Dictionary/profile/bloc/profile_bloc.dart';
import 'package:Dictionary/profile/service/profile_service.dart';
import 'package:Dictionary/search/bloc/word_search_bloc.dart';
import 'package:Dictionary/theme/theme_data.dart';
import 'package:Dictionary/utils/simple_bloc_observer.dart';
import 'package:Dictionary/authentication/screens/login_screen.dart';
import 'package:Dictionary/authentication/screens/register_screen.dart';
import 'package:Dictionary/cards/screen/card_screen.dart';
import 'package:Dictionary/authentication/screens/introduction_screen.dart';
import 'package:Dictionary/authentication/screens/auth_screen.dart';
import 'package:Dictionary/search/screen/search_screen.dart';
import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/theme/theme_colors.dart';
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
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(ProfileServiceImpl())),
      BlocProvider<FavWordsBloc>(
          create: (BuildContext context) =>
              FavWordsBloc(FavWordsServiceImpl())),
      BlocProvider<WordSearchBloc>(
        create: (BuildContext context) =>
            WordSearchBloc(repository: Repository()),
      )
    ],
    child: SplashScreen(
      userRepository: _userRepository,
    ),
  ));
}

class SplashScreen extends StatelessWidget {
  final UserRepository _userRepository;

  SplashScreen({required UserRepository userRepository})
      : _userRepository = userRepository;


  Widget build(BuildContext context) {
    return MaterialApp(
        theme: themeData,
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/searchScreen': (BuildContext context) => SearchScreen(),
          '/cardScreen': (BuildContext context) => CardScreen(),
          '/introductionScreen': (BuildContext context) => IntroductionScreen(),
          '/registerScreen': (BuildContext context) => RegisterScreen(),
          '/loginScreen': (BuildContext context) => LoginScreen()
        },
        home: SplashScreenView(
            navigateRoute: HomeScreen(
              userRepository: _userRepository,
            ),
            duration: 3,
            text: 'Dictionary.',
            textStyle: TextStyle(
                fontFamily: 'Futura', fontSize: 50, color: Colors.white),
            pageRouteTransition: PageRouteTransition.CupertinoPageRoute,
            backgroundColor: gradientColor));
  }
}
