import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/data/dto/genre.dart';
import 'package:movie/data/local/database.dart';
import 'package:movie/data/local/genre_repository.dart';

class Movie extends StatefulWidget {
  final int id;
  final String poster;
  final String title;
  final String genre;
  final String releaseDate;
  final num rating;

  Movie(
      {@required this.id,
      @required this.poster,
      @required this.title,
      @required this.genre,
      @required this.releaseDate,
      @required this.rating});

  @override
  State<StatefulWidget> createState() {
    return _MovieState();
  }
}

class _MovieState extends State<Movie> {
  GenreRepository genreRepository =
      GenreRepository(database: DatabaseHelper.instance.database);
  Genre genre;

  @override
  void initState() {
    genreRepository.getGenre(widget.id).then((value) {
      setState(() {
        genre = value;
      });
    });
    super.initState();
  }

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
              image: 'http://image.tmdb.org/t/p/w185/${widget.poster}'),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              top: 8,
            ),
            child: Text(
              "${widget.title}",
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
              Text(genre != null ? genre.name : ''),
              Row(
                children: <Widget>[
                  Icon(Icons.favorite_border),
                  SizedBox(
                    width: 4,
                  ),
                  Text("${widget.rating}")
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
