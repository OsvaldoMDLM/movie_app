import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movie_app/src/models/models.dart';
import 'package:movie_app/src/providers/movies_provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;


  // ignore: use_key_in_widget_constructors
  const CastingCards(this.movieId);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
              height: 260,
              child: CupertinoActivityIndicator(),
            );
        }

        final List<Cast> cast = snapshot.data!;

        return
        Container(
          width: double.infinity,
          height: 260,
          margin: const EdgeInsets.only(bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('Cast', style: Theme.of(context).textTheme.headline6),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cast.length,
                  itemBuilder: (BuildContext context, int index){
                    return  _CastCard(cast[index]);
                  }),
              ),
            ],
          )
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard(this.actor);
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 100,
      width: 115,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullprofilePath!),
              height: 130,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: textTheme.subtitle1!.copyWith(fontSize: 12),
          ),
          const SizedBox(
            height: 2.5,
          ),
          Text(
            actor.character!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: textTheme.caption,
          )
        ],
      ),
    );
  }
}
