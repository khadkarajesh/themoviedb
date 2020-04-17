import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Poster extends StatelessWidget {
  final String posterPath;
  final String title;
  final String year;

  Poster({this.posterPath, this.title, this.year});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              height: 150,
              placeholder: 'assets/placeholder.png',
              image: 'http://image.tmdb.org/t/p/w185/${this.posterPath}'),
        ),
        SizedBox(
          width: 16,
        ),
        Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${this.title}',
              style: Theme.of(context).textTheme.headline,
            ),
            Text('${this.year}')
          ],
        ),
      ],
    );
  }
}
