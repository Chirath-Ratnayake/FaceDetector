import 'package:faceDetector/UI/Home/home.dart';
import 'package:faceDetector/UI/Home/profile.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class BottomNavBar extends StatefulWidget {

 BottomNavBar({@required this.username});

  final String username;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  GlobalKey bottomNavigationKey = GlobalKey();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: _getPage(currentPage),
          ),
        ),
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.home, title: "Home", onclick: () {
                final FancyBottomNavigationState fState = bottomNavigationKey
                    .currentState as FancyBottomNavigationState;
                fState.setPage(0);
              }),
            TabData(iconData: Icons.search, title: "Search", onclick: () {
                final FancyBottomNavigationState fState = bottomNavigationKey
                    .currentState as FancyBottomNavigationState;
                fState.setPage(1);
              }),
            TabData(iconData: Icons.shopping_cart, title: "Basket", onclick: () {
                final FancyBottomNavigationState fState = bottomNavigationKey
                    .currentState as FancyBottomNavigationState;
                fState.setPage(2);
              }),
              TabData(iconData: Icons.shopping_cart, title: "Basket", onclick: () {
                final FancyBottomNavigationState fState = bottomNavigationKey
                    .currentState as FancyBottomNavigationState;
                fState.setPage(3);
              })
          ],
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          },
        ));
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return HomeView();
      case 1:
        return ProfileView(username: widget.username,);
      case 2:
        return HomeView();
      case 3:
        return HomeView();
      default:
        return HomeView();
    }
  }
}
