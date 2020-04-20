import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:movie/data/dto/genre.dart';
import 'package:movie/data/dto/movie_detail_dto.dart';
import 'package:movie/data/dto/paginate.dart';
import 'package:movie/data/local/database.dart';
import 'package:movie/data/local/genre_repository.dart';

import '../dto/movie_dto.dart';
import '../dto/video_dto.dart';

class ApiService {
  static const String BASE_URL = "api.themoviedb.org";
  static const apiKey = "3d9f6ef05faa3072ee2caf7fb6870964";
  var logger = Logger();
  var client = http.Client();
  GenreRepository genreRepository =
      GenreRepository(database: DatabaseHelper.instance.database);

  static final ApiService _apiService = ApiService._internal();

  factory ApiService() {
    return _apiService;
  }

  ApiService._internal();

  Future<Paginate<MovieDto>> getPaginatedMovies(category, page) async {
    try {
      var uri = Uri.https(BASE_URL, "/3/movie/$category",
          {'api_key': apiKey, 'page': page.toString()});
      var response = await client.get(uri.toString());
      var body = json.decode(response.body);
      List<dynamic> results = body['results'];
      var data = results.map((dynamic e) => MovieDto.fromJson(e)).toList();
      return Paginate<MovieDto>(
          totalResults: body['total_results'],
          totalPages: body['total_pages'],
          results: data);
    } on HttpException catch (e) {
      throw (e.message);
    }
  }

  Future<MovieDetailDto> getMovieDetail(int movieId) async {
    try {
      var uri = Uri.https(BASE_URL, "/3/movie/$movieId", {'api_key': apiKey});
      var response = await client.get(uri.toString());
      var body = json.decode(response.body);
      return MovieDetailDto().fromJson(body);
    } on HttpException catch (e) {
      throw (e.message);
    }
  }

  Future<Paginate<MovieDto>> getPaginatedSuggestedMovies(
      int movieId, category, page) async {
    try {
      var uri = Uri.https(BASE_URL, "/3/movie/$movieId/$category",
          {'api_key': apiKey, 'page': page.toString()});
      var response = await client.get(uri.toString());
      var body = json.decode(response.body);
      List<dynamic> results = body['results'];
      var data = results.map((dynamic e) => MovieDto.fromJson(e)).toList();
      return Paginate<MovieDto>(
          totalResults: body['total_results'],
          totalPages: body['total_pages'],
          results: data);
    } on HttpException catch (e) {
      throw (e.message);
    }
  }

  Future<List<VideoDto>> getVideos(int movieId) async {
    try {
      var uri =
          Uri.https(BASE_URL, "/3/movie/$movieId/videos", {'api_key': apiKey});
      var response = await client.get(uri.toString());
      var body = json.decode(response.body);
      List<dynamic> results = body['results'];
      return results.map((dynamic e) => VideoDto.fromJson(e)).toList();
    } on HttpException catch (e) {
      throw (e.message);
    }
  }

  Future<List<MovieDto>> getSuggestions(int movieId, category) async {
    try {
      var uri = Uri.https(
          BASE_URL, "3/movie/$movieId/$category", {'api_key': apiKey});
      var response = await client.get(uri.toString());
      var body = json.decode(response.body);
      List<dynamic> results = body['results'];
      return results.map((dynamic e) => MovieDto.fromJson(e)).toList();
    } on HttpException catch (e) {
      throw (e.message);
    }
  }

  void getGenres() async {
    try {
      int count = await genreRepository.getCount();
      if (count > 0) return;
      var uri = Uri.https(BASE_URL, "3/genre/movie/list", {'api_key': apiKey});
      var response = await client.get(uri.toString());
      var body = json.decode(response.body);
      List<dynamic> results = body['genres'];
      List<Genre> genres =
          results.map((dynamic e) => Genre.fromJson(e)).toList();
      genres.forEach((genre) async {
        await genreRepository.insert(genre);
      });
    } on HttpException catch (e) {
      throw (e.message);
    }
  }
}
