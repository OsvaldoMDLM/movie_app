// To parse this JSON data, do
//
//     final actorMovies = actorMoviesFromMap(jsonString);

import 'dart:convert';

import 'package:movie_app/src/models/models.dart';

class MoviesRecommended {
    MoviesRecommended({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;


    factory MoviesRecommended.fromJson(String str) => MoviesRecommended.fromMap(json.decode(str));

    factory MoviesRecommended.fromMap(Map<String, dynamic> json) => MoviesRecommended(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}