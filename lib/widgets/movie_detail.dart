import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/data/api/service.dart';
import 'package:movie/data/dto/movie_dto.dart';
import 'package:movie/data/dto/video_dto.dart';
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
  VideoDto video;
  List<VideoDto> videos = <VideoDto>[];

  @override
  Widget build(BuildContext context) {
    apiService.getVideos(widget.movie.id).then((value) => setState(() {
          video = value[0];
        }));

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        title: Text(""),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.bookmark), onPressed: null),
          IconButton(icon: Icon(Icons.search), onPressed: null),
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
        child: video == null
            ? CircularProgressIndicator()
            : ListView(
                children: <Widget>[
                  Video(
                    videoKey: video.key,
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
                        SuggestedMovies(
                          movieId: widget.movie.id,
                          category: "similar",
                        ),
//                        SuggestedMovies(
//                          movieId: widget.movie.id,
//                          category: "recommendations",
//                        )
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
