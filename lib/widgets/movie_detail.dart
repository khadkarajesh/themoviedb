import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/data/api/service.dart';
import 'package:movie/data/dto/movie_dto.dart';
import 'package:movie/widgets/overview.dart';
import 'package:movie/widgets/poster.dart';
import 'package:movie/widgets/recomendation_title.dart';
import 'package:movie/widgets/similar_movie_list.dart';
import 'package:movie/widgets/similar_movie_title.dart';
import 'package:movie/widgets/suggested_movie_grid.dart';
import 'package:movie/widgets/video.dart';

import 'movie_grid.dart';

class MovieDetail extends StatefulWidget {
  static const routeName = '/detail';
  final MovieDto movie;

  MovieDetail({this.movie});

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailState();
  }
}

class _MovieDetailState extends State<MovieDetail> {
  final ApiService apiService = ApiService();

  void navigate(context, movieId, title, uriPath) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SuggestedMovieGrid(
              category: title,
              uriPath: uriPath,
              movieId: movieId,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(""),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.bookmark,
                color: Colors.black,
              ),
              onPressed: null),
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: null),
          PopupMenuButton<Choice>(
            itemBuilder: (BuildContext context) {
              return choices
                  .map((e) => PopupMenuItem<Choice>(
                        value: e,
                        child: Text(e.title),
                      ))
                  .toList();
            },
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Video(
              movieId: widget.movie.id,
              posterUrl: widget.movie.backDropPath,
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Poster(
                    posterPath: widget.movie.posterPath,
                    title: widget.movie.title,
                    year: widget.movie.releaseDate,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Overview(
                    overview: widget.movie.overview,
                  ),
                  InkWell(
                    onTap: () {
                      navigate(
                        context,
                        widget.movie.id,
                        "Similar",
                        "similar",
                      );
                    },
                    child: SimilarMovieTitle(),
                  ),
                  SuggestedMovies(
                    movieId: widget.movie.id,
                    category: "similar",
                  ),
                  InkWell(
                    child: RecommendationTitle(),
                    onTap: () {
                      navigate(
                        context,
                        widget.movie.id,
                        "Recommended",
                        "recommendations",
                      );
                    },
                  ),
                  SuggestedMovies(
                    movieId: widget.movie.id,
                    category: "recommendations",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Share', icon: Icons.share)
];
