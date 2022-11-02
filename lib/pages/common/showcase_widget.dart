import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/palette_function.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/model/base_show_model.dart';
import 'package:flutter_application_1/model/movie_model.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:palette_generator/palette_generator.dart';

class ShowcaseWidget extends StatelessWidget {
  final IBaseShowModel media;
  final ImageProvider image;
  final PaletteGenerator? palette;

  const ShowcaseWidget(
    this.media, {
    Key? key,
    required this.image,
    this.palette,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double posterAspectRatio = 7 / 6;
    Color? scaffoldBackgroundColor = palette?.darkMutedColor?.color ??
        Theme.of(context).scaffoldBackgroundColor;
    String? title;
    int? runtime;
    DateTime? date;

    if (media is Movie) {
      title = (media as Movie).title;
      runtime = (media as Movie).runtime;
      date = (media as Movie).releaseDate;
    } else if (media is Tv) {
      title = (media as Tv).name;
      if ((media as Tv).episodeRunTime?.isNotEmpty ?? false) {
        runtime = (media as Tv).episodeRunTime?.first;
      }
      date = (media as Tv).firstAirDate;
    }

    return AspectRatio(
      aspectRatio: posterAspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          buildBackDropImage(media, image),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.6, 0.82],
                colors: [
                  scaffoldBackgroundColor.withOpacity(0),
                  scaffoldBackgroundColor,
                ],
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title ?? 'UNKNOWN',
                  style: TextStyles.robotoBoldStyle.copyWith(
                    color: palette?.lightVibrantColor?.color,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                Wrap(
                  children: [
                    if (date != null)
                      Text(
                        '${date.year}',
                        style: TextStyles.robotoRegular16Style,
                      ),
                    if (runtime != null)
                      Text(
                        ', Runtime: $runtime min',
                        style: TextStyles.robotoRegular16Style,
                      ),
                  ],
                ),
                buildRatingBar(media),
              ],
            ).separated(
              const SizedBox(
                height: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBackDropImage(IBaseShowModel media, ImageProvider placeholder) {
    String url = getImage(
      path: media.backdropPath,
      size: 'original',
    );
    final ImageProvider image = CachedNetworkImageProvider(url);
    Color dominantColor = palette?.primaryColor?.color ?? Colors.transparent;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
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
        ],
      ),
    );
  }

  Row buildRatingBar(IBaseShowModel media) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          media.voteAverage!.toStringAsFixed(1),
          style: TextStyles.robotoMedium18Style.copyWith(
            color: const Color(0xFFFDC432),
          ),
        ),
        RatingBar(
          ignoreGestures: true,
          itemSize: 20,
          initialRating: media.voteAverage! / 2,
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
          '(${media.voteCount!.toStringAsFixed(1)})',
          style: TextStyles.robotoRegular10Style.copyWith(
            color: Colors.white.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}
