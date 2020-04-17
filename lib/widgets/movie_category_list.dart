import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/data/category_dto.dart';
import 'package:movie/widgets/category.dart';

class MovieCategoryList extends StatelessWidget {
  List<CategoryDto> categories = [
    CategoryDto(
      title: "Now Playing",
      uriPath: "now_playing",
    ),
    CategoryDto(
      title: "Upcoming",
      uriPath: "upcoming",
    ),
    CategoryDto(
      title: "popular",
      uriPath: "popular",
    ),
    CategoryDto(
      title: "Top Rated",
      uriPath: "top_rated",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      padding: EdgeInsets.only(
        top: 32,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          var category = categories[index];
          return Category(
            title: category.title,
            uriPath: category.uriPath,
          );
        },
        itemCount: categories.length,
      ),
    );
  }
}
