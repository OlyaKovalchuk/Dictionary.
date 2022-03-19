import 'package:Dictionary/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomBar extends StatelessWidget {
  final int selectedPage;
  final Function(int)? onTap;

  BottomBar({Key? key, required this.selectedPage, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerNavBar(
        child: NavigationBar(selectedPage: selectedPage, onTap: onTap));
  }
}

class NavigationBar extends StatelessWidget {
  final int selectedPage;
  final Function(int)? onTap;

  NavigationBar({Key? key, required this.selectedPage, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
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
  }
}

class ContainerNavBar extends StatelessWidget {
  final Widget child;

  ContainerNavBar({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3))
          ]),
      child: child,
    );
  }
}
