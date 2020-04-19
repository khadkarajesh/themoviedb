import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/widgets/movie_list.dart';

import 'movie_grid.dart';

class Category extends StatelessWidget {
  final String title;
  final String uriPath;

  Category({this.title, this.uriPath});

  void navigate(context, category) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MoviePage(
              category: this.title,
              uriPath: this.uriPath,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              navigate(context, this.uriPath);
            },
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    this.title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Icon(Icons.arrow_forward),
                    ],
                  )
                ],
              ),
            ),
          ),
          MovieList(
            category: this.title,
            urlPath: this.uriPath,
          )
        ],
      ),
    );
  }
}
