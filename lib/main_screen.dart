import 'package:dictionary/authentication/service/firebase_auth_service.dart';
import 'package:dictionary/cards/screen/card_screen.dart';
import 'package:dictionary/favorite_words/screen/favorite_words_screen.dart';
import 'package:dictionary/profile/screen/profile_screen.dart';
import 'package:dictionary/search/search_screen.dart';
import 'package:dictionary/widgets/colors/grey_color.dart';
import 'package:dictionary/widgets/colors/red_color.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
