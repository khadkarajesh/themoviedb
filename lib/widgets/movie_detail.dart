import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/data/api/service.dart';
import 'package:movie/data/dto/movie_dto.dart';
import 'package:movie/widgets/overview.dart';
import 'package:movie/widgets/poster.dart';
import 'package:movie/widgets/similar_movie_list.dart';
import 'package:movie/widgets/video.dart';

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
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Similar Movies",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Popular with similar viewers",
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SuggestedMovies(
                    movieId: widget.movie.id,
                    category: "similar",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Recommendations",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                  SizedBox(
                    height: 16,
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
