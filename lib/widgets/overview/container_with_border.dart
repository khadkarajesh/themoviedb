import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  final Widget child;

  BorderContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: child,
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
