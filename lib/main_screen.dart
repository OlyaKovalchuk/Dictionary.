import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/cards/screen/card_screen.dart';
import 'package:Dictionary/favorite_words/screen/favorite_words_screen.dart';
import 'package:Dictionary/profile/screen/profile_screen.dart';
import 'package:Dictionary/search/screen/appBar_search.dart';
import 'package:Dictionary/search/screen/search_screen.dart';
import 'package:Dictionary/widgets/appBar.dart';
import 'package:Dictionary/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  UserRepositoryImpl userRepository = UserRepositoryImpl();
  PageController pageController = PageController(
    keepPage: true,
    initialPage: 1,
  );
  int selectedPage = 1;

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
      return buildAppBar(title: Text('Favorite Words'),context: context);
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
        bottomNavigationBar: bottomNavigationBar(selectedPage: selectedPage, onTap: _onItemTapped));
  }
}
