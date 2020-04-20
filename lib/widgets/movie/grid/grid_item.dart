import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieGridItem extends StatelessWidget {
  final String poster;
  final String title;
  final String genre;
  final String releaseDate;
  final num rating;

  MovieGridItem(
      {@required this.poster,
      @required this.title,
      @required this.genre,
      @required this.releaseDate,
      @required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage.assetNetwork(
              height: 180,
              fit: BoxFit.contain,
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
              Text("Sci-Fi"),
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
      ],
    ));
  }
}
