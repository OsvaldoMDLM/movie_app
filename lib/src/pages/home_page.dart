import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/src/providers/movies_provider.dart';
import 'package:movie_app/src/widgets/widgets.dart';
import 'package:movie_app/src/search/search_delegate.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('peliculas'),
          actions: [
            IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: MovieSearchDelegate()),
                icon: const Icon(Icons.search))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            MovieSlider(
              movies: moviesProvider.popularMovies, // populares,
              title: 'Populares', // opcional
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
          ],
        )));
  }
}
