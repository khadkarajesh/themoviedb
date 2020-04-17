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
      height: 400,
      width: 185,
      child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder.png',
                  image: 'http://image.tmdb.org/t/p/w185/${this.poster}'),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    top: 2,
                  ),
                  child: Text(
                    "${this.title}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
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
              )
            ],
          )),
    );
  }
}
