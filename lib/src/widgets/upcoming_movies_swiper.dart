import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:movie_app/src/models/models.dart';

class UpcomingSwiper extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  const UpcomingSwiper({Key? key, this.title, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _SliderMovie(size: size, movies: movies, title: title);
  }
}

class _SliderMovie extends StatelessWidget {
  const _SliderMovie({
    Key? key,
    required this.size,
    required this.movies,
    required this.title,
  }) : super(key: key);

  final Size size;
  final List<Movie> movies;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: movies.length > 3
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      title!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                Swiper(
                  itemCount: movies.length,
                  layout: SwiperLayout.CUSTOM,
                  customLayoutOption:  CustomLayoutOption(
                          startIndex: -1, stateCount: 3)
                      .addRotate([-25.0 / 180, 0.0, 25.0 / 180]).addTranslate([
                    const Offset(-370.0, -40.0),
                    const Offset(0.0, 0.0),
                    const Offset(370.0, -40.0)
                  ]),
                  itemWidth: size.width * 0.7,
                  itemHeight: size.height * 0.45,
                  itemBuilder: (BuildContext contex, int index) {
                    final movie = movies[index];
                    movie.heroId = 'swipter-${movie.id}';
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'details',
                          arguments: movie),
                      child: Hero(
                        tag: movie.heroId!,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/no-image.jpg'),
                            image: NetworkImage(movie.fullPosterImg),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          : null,
    );
  }
}
