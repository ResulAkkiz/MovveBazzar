import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/palette_function.dart';
import 'package:flutter_application_1/model/movie_model.dart';
import 'package:palette_generator/palette_generator.dart';

class MovieDetailGenresWidget extends StatelessWidget {
  final Movie movie;
  final PaletteGenerator? palette;

  const MovieDetailGenresWidget(
    this.movie, {
    Key? key,
    this.palette,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.shortestSide * 0.15,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: movie.genres!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Chip(
              label: Text(
                movie.genres![index].name ?? '',
                style: TextStyle(
                  color: palette?.primaryColor?.bodyTextColor,
                ),
              ),
              backgroundColor: palette?.primaryColor?.color ??
                  Theme.of(context).primaryColor,
            ),
          );
        },
      ),
    );
  }
}
