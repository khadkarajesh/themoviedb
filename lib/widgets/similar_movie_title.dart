import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimilarMovieTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Similar Movies",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Popular with similar viewers",
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            width: 16.0,
          ),
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
