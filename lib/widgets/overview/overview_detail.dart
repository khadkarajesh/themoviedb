import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/data/api/service.dart';
import 'package:movie/data/dto/movie_detail_dto.dart';
import 'package:movie/widgets/overview/container_with_border.dart';

class OverViewDetail extends StatefulWidget {
  final int movieId;
  final String title;
  final String poster;

  OverViewDetail({this.movieId, this.title, this.poster});

  @override
  State<StatefulWidget> createState() {
    return _OverViewDetailState();
  }
}

class _OverViewDetailState extends State<OverViewDetail> {
  MovieDetailDto movieDetail;
  ApiService apiService = ApiService();
  var isLoading = false;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    apiService.getMovieDetail(widget.movieId).then((movieDetail) {
      setState(() {
        isLoading = false;
        this.movieDetail = movieDetail;
      });
    }).then((error) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage.assetNetwork(
              height: 36,
              width: 36,
              fit: BoxFit.contain,
              placeholder: 'assets/placeholder.png',
              image: 'http://image.tmdb.org/t/p/w185/${widget.poster}'),
        ),
        flexibleSpace: Text(widget.title),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                BorderContainer(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                          ),
                          child: Text(
                            "About this movie",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          movieDetail.overview,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
