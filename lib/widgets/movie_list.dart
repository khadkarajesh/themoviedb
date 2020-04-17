import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/data/api/service.dart';
import 'package:movie/data/movie_dto.dart';

import 'movie.dart';
import 'movie_detail.dart';

class MovieList extends StatelessWidget {
  final ApiService apiService = ApiService();
  final String category;
  final String urlPath;

  MovieList({this.category, this.urlPath});

  void navigate(context, movie) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieDetail(
          movie: movie,
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 325,
      child: FutureBuilder(
        builder: (context, AsyncSnapshot<List<MovieDto>> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState ==
                  ConnectionState.done) if (snapshot.hasData) {
            var movies = snapshot.data;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              shrinkWrap: true,
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
              },
            );
          }
          if (snapshot.hasError &&
              snapshot.connectionState == ConnectionState.done) {
            return Text("${snapshot.error}");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        future: apiService.getMovies(this.urlPath),
      ),
    );
  }
}

