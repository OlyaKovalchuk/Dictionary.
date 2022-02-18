import 'dart:async';
import 'dart:developer' as developer;
import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/cards/screen/card_screen.dart';
import 'package:Dictionary/favorite_words/screen/favorite_words_screen.dart';
import 'package:Dictionary/profile/screen/profile_screen.dart';
import 'package:Dictionary/search/screen/app_bar_search.dart';
import 'package:Dictionary/search/screen/search_screen.dart';
import 'package:Dictionary/search/utils/error_output.dart';
import 'package:Dictionary/widgets/app_bar.dart';
import 'package:Dictionary/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

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
      return buildAppBar(title: Text('Profile'), context: context);
    } else if (selectedPage == 1) {
      return buildAppBar(context: context);
    } else if (selectedPage == 2) {
      return buildAppBar(title: Text('Favorite Words'), context: context);
    } else if (selectedPage == 3) {
      return buildAppBar(title: textFieldBoard(context), context: context);
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
        bottomNavigationBar: bottomNavigationBar(
            selectedPage: selectedPage, onTap: _onItemTapped));
  }
}
