import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

Widget bottomNavigationBar(
        {required int selectedPage, required Function(int)? onTap}) =>
    _containerForNavBar(
        child: _navigationBar(selectedPage: selectedPage, onTap: onTap));

Widget _navigationBar(
        {required int selectedPage, required Function(int)? onTap}) =>
    SalomonBottomBar(
      onTap: onTap,
      unselectedItemColor: greyDarkColor,
      selectedItemColor: redColor,
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
            icon: Icon(Icons.bookmarks_outlined), title: Text('Favorites')),
        SalomonBottomBarItem(icon: Icon(Icons.search), title: Text('Search')),
      ],
    );

Widget _containerForNavBar({required Widget child}) => Container(
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
      child: child,
    );
