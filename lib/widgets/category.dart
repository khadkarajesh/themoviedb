import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/widgets/movie_list.dart';

class Category extends StatelessWidget {
  final String title;
  final String uriPath;

  Category({this.title, this.uriPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 8,
      ),
      child: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                this.title,
                style: Theme.of(context).textTheme.headline,
              ),
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Icon(Icons.arrow_forward),
                ],
              )
            ],
          ),
          SizedBox(
            height: 8,
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
