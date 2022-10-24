import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:palette_generator/palette_generator.dart';

class ShowcaseWidget extends StatelessWidget {
  final Tv tv;
  final ImageProvider image;
  final PaletteGenerator? palette;

  const ShowcaseWidget(
    this.tv, {
    Key? key,
    required this.image,
    this.palette,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        buildBackDropImage(image),
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
                  Colors.transparent,
                  palette?.darkMutedColor?.color ??
                      Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    tv.name ?? 'UNKNOWN',
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
                      '${tv.firstAirDate!.year}',
                      style: TextStyles.robotoRegular16Style,
                    ),
                    if (tv.episodeRunTime != null &&
                        tv.episodeRunTime!.isNotEmpty)
                      Text(
                        ', Runtime: ${tv.episodeRunTime?.first} min',
                        style: TextStyles.robotoRegular16Style,
                      ),
                  ],
                ),
                buildRatingBar(tv),
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

  Widget buildBackDropImage(ImageProvider image) {
    const double posterAspectRatio = 7 / 6;

    return AspectRatio(
      aspectRatio: posterAspectRatio,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: palette?.dominantColor?.color,
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Row buildRatingBar(Tv tv) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tv.voteAverage!.toStringAsFixed(1),
          style: TextStyles.robotoMedium18Style.copyWith(
            color: const Color(0xFFFDC432),
          ),
        ),
        RatingBar(
          ignoreGestures: true,
          itemSize: 20,
          initialRating: tv.voteAverage! / 2,
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
          '(${tv.voteCount!.toStringAsFixed(1)})',
          style: TextStyles.robotoRegular10Style.copyWith(
            color: Colors.white.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}
