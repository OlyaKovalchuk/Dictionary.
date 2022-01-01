import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/cards/screen/card_screen.dart';
import 'package:Dictionary/favorite_words/screen/favorite_words_screen.dart';
import 'package:Dictionary/profile/screen/profile_screen.dart';
import 'package:Dictionary/search/screen/appBar_search.dart';
import 'package:Dictionary/search/screen/search_screen.dart';
import 'package:Dictionary/widgets/appBar.dart';
import 'package:Dictionary/widgets/colors/grey_color.dart';
import 'package:Dictionary/widgets/colors/red_color.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
      return buildAppBar(title: 'Profile');
    } else if (selectedPage == 1) {
      return buildAppBar();
    } else if (selectedPage == 2) {
      return buildAppBar(title: 'Favorite Words');
    } else if (selectedPage == 3) {
      return appBarSearch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppbar(),
        backgroundColor: Colors.white,
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
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
          child: SalomonBottomBar(
            onTap: _onItemTapped,
            unselectedItemColor: greyColor(),
            selectedItemColor: redColor(),
            selectedColorOpacity: 0.1,
            currentIndex: selectedPage,
            items: [
              SalomonBottomBarItem(
                icon: Icon(Icons.person_outline_outlined),
                title: Text('Profile'),
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.content_copy_outlined),
                title: Text('Cards'),
              ),
              SalomonBottomBarItem(
                  icon: Icon(Icons.bookmarks_outlined),
                  title: Text('Favorites')),
              SalomonBottomBarItem(
                  icon: Icon(Icons.search), title: Text('Search')),
            ],
          ),
        ));
  }
}
