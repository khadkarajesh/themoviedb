import 'package:flutter/cupertino.dart';

bool checkConnection() {
  return true;
}


bool isScrollReachedToEnd(ScrollController scrollController) {
  return scrollController.position.maxScrollExtent >
      scrollController.offset &&
      scrollController.position.maxScrollExtent - scrollController.offset <=
          50;
}

bool isScrollReachedToTop(ScrollController scrollController) {
  return scrollController.position.atEdge &&
      scrollController.position.pixels == 0;
}