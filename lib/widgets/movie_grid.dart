import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/data/api/service.dart';
import 'package:movie/data/dto/movie_dto.dart';
import 'package:movie/data/dto/paginate.dart';
import 'package:movie/widgets/grid_item.dart';

import 'movie_detail.dart';

//https://github.com/CodingInfinite/FutureBuilderWithPagination/blob/master/lib/main.dart

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
  var _scrollController = ScrollController();
  var page = 1;
  var totalPages = 1;
  List<MovieDto> movies = List();
  var isLoading = false;

  void navigate(context, movie) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieDetail(
              movie: movie,
            )));
  }

  @override
  void initState() {
    super.initState();
    apiService.getPaginatedMovies(widget.uriPath, page).then((value) {
      setState(() {
        isLoading = false;
        movies.addAll(value.results);
      });
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
      SnackBar(content: onError);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels == 0) {
        page = 1;
      } else if (_scrollController.position.atEdge &&
          _scrollController.position.pixels > 0) {
        page = page++;
        setState(() {
          isLoading = true;
        });
        apiService.getPaginatedMovies(widget.uriPath, page).then((value) {
          setState(() {
            movies.addAll(value.results);
            isLoading = false;
          });
        });
      }
    });
  }

  Widget getView() {
    if (isLoading && movies.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (isLoading) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: CircularProgressIndicator(),
      );
    }
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width / 2;

    return GridView.builder(
        itemCount: movies.length,
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemBuilder: (context, index) {
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
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: getView(),
        ));
  }
}

class MoviePage extends StatefulWidget {
  final String category;
  final String uriPath;
  int page = 1;

  MoviePage({this.category, this.uriPath});

  @override
  State<StatefulWidget> createState() {
    return _MoviePage();
  }
}

class _MoviePage extends State<MoviePage> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
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

  @override
  void initState() {
    movies = widget.movies;
    currentPage = widget.currentPage;

    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels == 0) {
        currentPage = 1;
      } else if (scrollController.position.maxScrollExtent >
              scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        if (currentPage < widget.totalPages) {
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

    return isLoading
        ? Align(
            alignment: Alignment.bottomCenter,
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            itemCount: movies.length,
            controller: scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: (itemWidth / itemHeight),
            ),
            itemBuilder: (context, index) {
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
            });
  }
}
