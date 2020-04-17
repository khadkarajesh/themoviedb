import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Overview extends StatelessWidget {
  final String overview;

  Overview({this.overview});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "About this movie",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
            Icon(Icons.arrow_forward)
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          this.overview,
          maxLines: 4,
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
