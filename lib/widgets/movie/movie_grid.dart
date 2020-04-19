import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/data/api/service.dart';
import 'package:movie/data/dto/movie_dto.dart';
import 'package:movie/data/dto/paginate.dart';
import 'package:movie/widgets/movie/grid_item.dart';
import 'package:movie/widgets/loading_indicator.dart';

import 'movie_detail.dart';

//https://github.com/CodingInfinite/FutureBuilderWithPagination/blob/master/lib/main.dart

class MovieGrid extends StatefulWidget {
  final String category;
  final String uriPath;
  int page = 1;

  MovieGrid({this.category, this.uriPath});

  @override
  State<StatefulWidget> createState() {
    return _GridMovieItem();
  }
}

class _GridMovieItem extends State<MovieGrid> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          widget.category,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder<Paginate<MovieDto>>(
          future: apiService.getPaginatedMovies(widget.uriPath, widget.page),
          builder: (context, AsyncSnapshot<Paginate<MovieDto>> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState ==
                    ConnectionState.done) if (snapshot.hasData) {
              return MovieTile(
                movies: snapshot.data.results,
                currentPage: widget.page,
                totalPages: snapshot.data.totalPages,
                uriPath: widget.uriPath,
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
      ),
    );
  }
}

class MovieTile extends StatefulWidget {
  final List<MovieDto> movies;
  final int currentPage;
  final String uriPath;
  final int totalPages;

  MovieTile(
      {Key key, this.movies, this.currentPage, this.totalPages, this.uriPath});

  @override
  State<StatefulWidget> createState() {
    return _MovieTileState();
  }
}

class _MovieTileState extends State<MovieTile> {
  final ScrollController scrollController = ScrollController();
  List<MovieDto> movies;
  int currentPage;
  ApiService apiService = ApiService();
  bool isLoading = false;

  bool isScrollReachedToEnd() {
    return scrollController.position.maxScrollExtent >
            scrollController.offset &&
        scrollController.position.maxScrollExtent - scrollController.offset <=
            50;
  }

  bool isScrollReachedToTop() {
    return scrollController.position.atEdge &&
        scrollController.position.pixels == 0;
  }

  @override
  void initState() {
    movies = widget.movies;
    currentPage = widget.currentPage;

    scrollController.addListener(() {
      if (isScrollReachedToTop()) {
        currentPage = 1;
      } else if (isScrollReachedToEnd()) {
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
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width / 2;

    return GridView.builder(
      itemCount: isLoading ? movies.length + 1 : movies.length,
      controller: scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: (itemWidth / itemHeight),
      ),
      itemBuilder: (context, index) {
        if (index == movies.length) {
          return LoadingIndicator();
        }
        var movie = movies[index];
        return GestureDetector(
          onTap: () {
            navigate(context, movie);
          },
          child: MovieGridItem(
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
