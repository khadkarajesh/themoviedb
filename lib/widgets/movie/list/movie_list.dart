import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/data/api/service.dart';
import 'package:movie/data/dto/movie_dto.dart';
import 'package:movie/data/dto/paginate.dart';
import 'package:movie/utils/app.dart';
import 'package:movie/widgets/loading_indicator.dart';

import '../movie.dart';
import '../detail/movie_detail.dart';

class MovieList extends StatefulWidget {
  final String category;
  final String urlPath;
  int page = 1;

  MovieList({this.category, this.urlPath});

  @override
  State<StatefulWidget> createState() {
    return _MovieListState();
  }
}

class _MovieListState extends State<MovieList> {
  final ApiService apiService = ApiService();

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
      margin: EdgeInsets.only(left: 16, right: 16),
      child: FutureBuilder<Paginate<MovieDto>>(
        builder: (context, AsyncSnapshot<Paginate<MovieDto>> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState ==
                  ConnectionState.done) if (snapshot.hasData) {
            return SingleMovieItem(
              movies: snapshot.data.results,
              currentPage: widget.page,
              totalPages: snapshot.data.totalPages,
              uriPath: widget.urlPath,
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
        future: apiService.getPaginatedMovies(widget.urlPath, 1),
      ),
    );
  }
}

class SingleMovieItem extends StatefulWidget {
  final List<MovieDto> movies;
  final int currentPage;
  final String uriPath;
  final int totalPages;

  SingleMovieItem(
      {Key key, this.movies, this.currentPage, this.totalPages, this.uriPath});

  @override
  State<StatefulWidget> createState() {
    return _SingleMovieItem();
  }
}

class _SingleMovieItem extends State<SingleMovieItem> {
  final ScrollController scrollController = ScrollController();
  List<MovieDto> movies;
  int currentPage;
  ApiService apiService = ApiService();
  bool isLoading = false;

  @override
  void initState() {
    movies = widget.movies;
    currentPage = widget.currentPage;

    scrollController.addListener(() {
      if (isScrollReachedToTop(scrollController)) {
        currentPage = 1;
      } else if (isScrollReachedToEnd(scrollController)) {
        if (currentPage < widget.totalPages) {
          setState(() {
            isLoading = true;
          });
          currentPage++;
          apiService
              .getPaginatedMovies(widget.uriPath, currentPage)
              .then((value) {
            isLoading = false;
            setState(() {
              movies.addAll(value.results);
            });
          });
        }
      }
    });
    super.initState();
  }

  void navigate(context, movie) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieDetail(
              movie: movie,
            )));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: isLoading ? movies.length + 1 : movies.length,
      controller: scrollController,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == movies.length) {
          return LoadingIndicator();
        }

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
}
