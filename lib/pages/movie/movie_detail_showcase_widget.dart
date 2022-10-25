import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/model/movie_model.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:palette_generator/palette_generator.dart';

class MovieDetailShowcaseWidget extends StatelessWidget {
  final Movie movie;
  final ImageProvider image;
  final PaletteGenerator? palette;

  const MovieDetailShowcaseWidget(
    this.movie, {
    Key? key,
    required this.image,
    this.palette,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? scaffoldBackgroundColor = palette?.darkMutedColor?.color ??
        Theme.of(context).scaffoldBackgroundColor;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        buildBackDropImage(movie, image),
        Positioned(
          bottom: -2,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.shortestSide * 0.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.6],
                colors: [
                  scaffoldBackgroundColor.withOpacity(0),
                  scaffoldBackgroundColor,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    movie.title ?? 'UNKNOWN',
                    style: TextStyles.robotoBoldStyle.copyWith(
                      color: palette?.lightVibrantColor?.color,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Wrap(
                  children: [
                    Text(
                      '${movie.releaseDate?.year}',
                      style: TextStyles.robotoRegular16Style,
                    ),
                    if (movie.runtime != null)
                      Text(
                        ', Runtime: ${movie.runtime} min',
                        style: TextStyles.robotoRegular16Style,
                      ),
                  ],
                ),
                buildRatingBar(movie),
              ],
            ).separated(
              const SizedBox(
                height: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBackDropImage(Movie movie, ImageProvider placeholder) {
    String url = getImage(
      path: movie.backdropPath,
      size: 'original',
    );
    final ImageProvider image = CachedNetworkImageProvider(url);
    const double posterAspectRatio = 7 / 6;
    Color? dominantColor = palette?.dominantColor?.color;

    return AspectRatio(
        aspectRatio: posterAspectRatio,
        child: Stack(fit: StackFit.expand, children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: dominantColor,
              image: DecorationImage(
                image: placeholder,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Image(
            image: image,
            fit: BoxFit.cover,
          ),
        ]));
  }

  Row buildRatingBar(Movie movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          movie.voteAverage!.toStringAsFixed(1),
          style: TextStyles.robotoMedium18Style.copyWith(
            color: const Color(0xFFFDC432),
          ),
        ),
        RatingBar(
          ignoreGestures: true,
          itemSize: 20,
          initialRating: movie.voteAverage! / 2,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          onRatingUpdate: (rating) {},
          ratingWidget: RatingWidget(
            full: IconEnums.fullstar.toImage,
            half: IconEnums.halfstar.toImage,
            empty: IconEnums.emptystar.toImage,
          ),
        ),
        Text(
          '(${movie.voteCount!.toStringAsFixed(1)})',
          style: TextStyles.robotoRegular10Style.copyWith(
            color: Colors.white.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}
