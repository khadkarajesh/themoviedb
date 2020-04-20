import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/data/api/service.dart';
import 'package:movie/data/dto/movie_dto.dart';

import '../movie.dart';
import '../detail/movie_detail.dart';

class SuggestedMovies extends StatefulWidget {
  final int movieId;
  final String category;

  SuggestedMovies({this.movieId, this.category});

  @override
  State<StatefulWidget> createState() {
    return _SuggestedMoviesState(movieId: movieId, category: category);
  }
}

class _SuggestedMoviesState extends State<SuggestedMovies> {
  final int movieId;
  final String category;
  final ApiService service = ApiService();

  _SuggestedMoviesState({@required this.movieId, @required this.category});

  void navigate(context, movie) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieDetail(
              movie: movie,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: FutureBuilder(
        future: service.getSuggestions(movieId, category),
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
