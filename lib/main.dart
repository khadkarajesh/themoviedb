import 'package:flutter/material.dart';
import 'package:movie/widgets/app_navigation.dart';
import 'package:movie/widgets/movie_detail.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AppBottomNavigation(),
      routes: <String, WidgetBuilder>{
        MovieDetail.routeName: (BuildContext context) => MovieDetail(),
      },
    );
  }
}
