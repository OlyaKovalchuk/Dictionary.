import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'authentication/service/firebase_auth_service.dart';
import 'cards/screen/card_screen.dart';
import 'favorite_words/screen/favorite_words_screen.dart';
import 'profile/screen/profile_screen.dart';
import 'search/widgets/app_bar_search.dart';
import 'search/screen/search_screen.dart';
import 'search/utils/error_output.dart';
import 'widgets/app_bar.dart';
import 'widgets/bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  UserRepository? userRepository;
  PageController pageController = PageController(
    keepPage: true,
    initialPage: 1,
  );
  int selectedPage = 1;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
    initConnectivity();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        errorOutput(error: 'Check your internet connection', context: context);
      }
    } on PlatformException catch (e) {
      developer.log("Couldn\'t check connectivity status", error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(connectivityResult);
  }

  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedPage = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  getAppbar() {
    if (selectedPage == 0) {
      return AppBarBuilder(title: Text('Profile'));
    } else if (selectedPage == 1) {
      return AppBarBuilder(title: Text('Dictionary.'));
    } else if (selectedPage == 2) {
      return AppBarBuilder(title: Text('Favorite Words'));
    } else if (selectedPage == 3) {
      return AppBarBuilder(title: TextFieldBoard());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppbar(),
        resizeToAvoidBottomInset: false,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            ProfileScreen(),
            CardScreen(),
            FavoriteWordsScreen(),
            SearchScreen(),
          ],
        ),
        extendBody: true,
        bottomNavigationBar:
            BottomBar(selectedPage: selectedPage, onTap: _onItemTapped));
  }
}
