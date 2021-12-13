import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:movie_app/src/models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: movies.length > 3
          ? Swiper(
              itemCount: movies.length,
              layout: SwiperLayout.STACK,
              itemWidth: size.width * 0.6,
              itemHeight: size.height * 0.4,
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
                        placeholder: AssetImage('assets/no-image.jpg'),
                        image: NetworkImage(movie.fullPosterImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            )
          : null,
    );
  }
}
