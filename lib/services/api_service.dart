// 가장 인기 있는 영화: https://movies-api.nomadcoders.workers.dev/popular
// 극장에서 상영 중인 영화: https://movies-api.nomadcoders.workers.dev/now-playing
// 곧 개봉하는 영화: https://movies-api.nomadcoders.workers.dev/coming-soon
// 영화에 대한 세부 정보: https://movies-api.nomadcoders.workers.dev/movie?id=1

import 'dart:convert';

import 'package:flutter_movie/models/movie_detail_model.dart';
import 'package:flutter_movie/models/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseURL = 'https://movies-api.nomadcoders.workers.dev';
  static const String popular = 'popular';
  static const String nowPlaying = 'now-playing';
  static const String comingSoon = 'coming-soon';

  static Future<List<MovieModel>> getPopulars() async {
    List<MovieModel> populars = [];
    final url = Uri.parse('$baseURL/$popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        populars.add(MovieModel.fromJson(movie));
      }
      return populars;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getNowPlayings() async {
    List<MovieModel> nowPlayings = [];
    final url = Uri.parse('$baseURL/$nowPlaying');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        nowPlayings.add(MovieModel.fromJson(movie));
      }
      return nowPlayings;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getComingSoon() async {
    List<MovieModel> comingSoons = [];
    final url = Uri.parse('$baseURL/$comingSoon');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        comingSoons.add(MovieModel.fromJson(movie));
      }
      return comingSoons;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieById(int id) async {
    final url = Uri.parse('$baseURL/movie?id=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      return MovieDetailModel.fromJson(movie);
    }
    throw Error();
  }
}
