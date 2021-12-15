import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movie_app/src/helpers/debouncer.dart';
import 'package:movie_app/src/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '35169fa9b1c34338dee2c44b9bfc7e87';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-MX';
  final String _region = 'MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> upcomingMovies = [];
  
  Map<int, List<Cast>> moviesCast = {};
  Map<int, List<Movie>> moviesRecommend = {};

  int _popularPage = 0;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<List<Movie>> _searchStreamController =
      StreamController.broadcast();
  Stream<List<Movie>> get suggestionsStream => _searchStreamController.stream;

  MoviesProvider() {
    getUpcomigMovies();
    getNowPlayingMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
      'region': _region
    });

    final response = await http.get(url);
    return response.body;
  }

  getUpcomigMovies() async {
    final jsonData = await _getJsonData('3/movie/upcoming');
    final upcomingResponse = UpcomingMovies.fromJson(jsonData);
    upcomingMovies = upcomingResponse.results;
    notifyListeners();
  }

  getNowPlayingMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Movie>> getMoviesRecommend(int movieId) async {
    final jsonData = await _getJsonData('3/movie/$movieId/recommendations');
    final moviesRecommendedResponse = MoviesRecommended.fromJson(jsonData);
    moviesRecommend[movieId] = moviesRecommendedResponse.results;
    return moviesRecommendedResponse.results;
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovie(value);
      _searchStreamController.add(results);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(const Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
