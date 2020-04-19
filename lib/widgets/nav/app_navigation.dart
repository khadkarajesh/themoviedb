import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/widgets/search/search.dart';
import 'package:movie/widgets/tvshow/tv_shows.dart';

import '../account/account.dart';
import '../movie/movie_category_list.dart';

class AppBottomNavigation extends StatefulWidget {
  AppBottomNavigation({Key key}) : super(key: key);

  _AppBottomNavigation createState() => _AppBottomNavigation();
}

class _AppBottomNavigation extends State<AppBottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.animateToPage(
        index,
        duration: Duration(microseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        MovieCategoryList(),
        Search(),
        MovieCategoryList(),
        TvShows(),
        Account()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              "Home",
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
              "Search",
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            title: Text(
              "Movie",
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tv,
            ),
            title: Text(
              "Tv Show",
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text(
              "Account",
            ),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[800],
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
    );
  }
}
