import 'dart:ffi';

class MovieDto {
  final int id;
  final String title;
  final String overview;
  final num voteAverage;
  final String releaseDate;
  final String posterPath;
  final String backDropPath;
  final bool video;

  MovieDto(
      {this.id,
        this.title,
        this.overview,
        this.voteAverage,
        this.releaseDate,
        this.posterPath,
        this.backDropPath,
        this.video});

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        voteAverage: json['vote_average'],
        releaseDate: json['release_date'],
        posterPath: json['poster_path'],
        backDropPath: json['backdrop_path'],
        video: json['video']);
  }
}
