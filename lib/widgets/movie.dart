import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Movie extends StatelessWidget {
  final String poster;
  final String title;
  final String genre;
  final String releaseDate;
  final num rating;

  Movie(
      {@required this.poster,
      @required this.title,
      @required this.genre,
      @required this.releaseDate,
      @required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 130,
      margin: EdgeInsets.only(right: 16),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage.assetNetwork(
              height: 160,
              width: 130,
              fit: BoxFit.fill,
              placeholder: 'assets/placeholder.png',
              image: 'http://image.tmdb.org/t/p/w185/${this.poster}'),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              top: 8,
            ),
            child: Text(
              "${this.title}",
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Sci-Fi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.favorite_border),
                  SizedBox(
                    width: 4,
                  ),
                  Text("${this.rating}")
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
