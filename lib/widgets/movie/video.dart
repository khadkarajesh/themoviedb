import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/data/api/service.dart';
import 'package:movie/data/dto/video_dto.dart';
import 'package:url_launcher/url_launcher.dart';

class Video extends StatefulWidget {
  final String posterUrl;
  final int movieId;

  Video({this.movieId, this.posterUrl});

  @override
  State<StatefulWidget> createState() {
    return _Video();
  }
}

class _Video extends State<Video> {
  ApiService apiService = ApiService();
  VideoDto video;

  void openYoutube() async {
    var url = Uri.https(
      "www.youtube.com",
      "/watch",
      {"v": video.key},
    ).toString();
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  void fetch() {
    apiService.getVideos(widget.movieId).then((value) => setState(() {
          video = value[0];
        }));
  }

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Builder(builder: (context) {
            return widget.posterUrl == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: 'assets/placeholder.png',
                    image:
                        'http://image.tmdb.org/t/p/w500/${widget.posterUrl}');
          }),
        ),
        IconButton(
          icon: Icon(
            Icons.play_circle_filled,
            size: 48,
          ),
          color: Colors.white,
          onPressed: () {
            openYoutube();
          },
        )
      ],
    );
  }
}
