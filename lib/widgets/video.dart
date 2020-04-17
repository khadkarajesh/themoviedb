import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Video extends StatelessWidget {
  final String posterUrl;
  final String videoKey;

  Video({this.posterUrl, this.videoKey});

  void openYoutube() async {
    var url = Uri.https(
      "www.youtube.com",
      "/watch",
      {"v": videoKey},
    ).toString();
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Builder(builder: (context) {
            return posterUrl == null
                ? Center(
              child: CircularProgressIndicator(),
            )
                : FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/placeholder.png',
                image: 'http://image.tmdb.org/t/p/w500/${this.posterUrl}');
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
