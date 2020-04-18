import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/data/api/service.dart';
import 'package:movie/data/dto/movie_dto.dart';

import 'movie.dart';
import 'movie_detail.dart';

class MovieGrid extends StatefulWidget {
  final String category;
  final String uriPath;

  MovieGrid({this.category, this.uriPath});

  @override
  State<StatefulWidget> createState() {
    return _MovieGrid();
  }
}

class _MovieGrid extends State<MovieGrid> {
  final ApiService apiService = ApiService();

  void navigate(context, movie) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieDetail(
              movie: movie,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
        ),
        body: FutureBuilder<List<MovieDto>>(
            future: apiService.getMovies(widget.uriPath),
            builder: (context, AsyncSnapshot<List<MovieDto>> snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState ==
                      ConnectionState.done) if (snapshot.hasData) {
                var movies = snapshot.data;
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      var movie = movies[index];
                      return GestureDetector(
                        onTap: () {
                          navigate(context, movie);
                        },
                        child: Movie(
                          poster: movie.posterPath,
                          title: movie.title,
                          genre: "",
                          releaseDate: movie.releaseDate,
                          rating: movie.voteAverage,
                        ),
                      );
                    });
              }
              if (snapshot.hasError &&
                  snapshot.connectionState == ConnectionState.done) {
                return Text("${snapshot.error}");
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
