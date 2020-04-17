import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../movie_dto.dart';
import '../video_dto.dart';

class ApiService {
  static const String BASE_URL = "api.themoviedb.org";
  static const apiKey = "3d9f6ef05faa3072ee2caf7fb6870964";
  var logger = Logger();
  var client = http.Client();

  static final ApiService _apiService = ApiService._internal();

  factory ApiService() {
    return _apiService;
  }

  ApiService._internal();

  Future<List<MovieDto>> getMovies(String category) async {
    try {
      var uri = Uri.https(BASE_URL, "/3/movie/$category", {'api_key': apiKey});
      var response = await client.get(uri.toString());
      var body = json.decode(response.body);
      List<dynamic> results = body['results'];
      return results.map((dynamic e) => MovieDto.fromJson(e)).toList();
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
}