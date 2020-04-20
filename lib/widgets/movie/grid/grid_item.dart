import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/data/dto/genre.dart';
import 'package:movie/data/local/database.dart';
import 'package:movie/data/local/genre_repository.dart';

class MovieGridItem extends StatefulWidget {
  final int genreId;
  final String poster;
  final String title;
  final String genre;
  final String releaseDate;
  final num rating;

  MovieGridItem(
      {@required this.genreId,
      @required this.poster,
      @required this.title,
      @required this.genre,
      @required this.releaseDate,
      @required this.rating});

  @override
  State<StatefulWidget> createState() {
    return _StateMovieGridItem();
  }
}

class _StateMovieGridItem extends State<MovieGridItem> {
  GenreRepository genreRepository =
      GenreRepository(database: DatabaseHelper.instance.database);
  Genre genre;

  @override
  void initState() {
    genreRepository.getGenre(widget.genreId).then((value) {
      setState(() {
        genre = value;
      });
    });
    super.initState();
  }

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
      ],
    ));
  }
}
