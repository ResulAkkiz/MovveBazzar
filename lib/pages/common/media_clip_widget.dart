import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';
import 'package:flutter_application_1/model/tv_trending_model.dart';
import 'package:intl/intl.dart';

class MediaClipWidget extends StatelessWidget {
  final IBaseTrendingModel media;
  final double aspectRatio;

  const MediaClipWidget(
    this.media, {
    Key? key,
    required this.aspectRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? title;
    DateTime? date;
    String? posterPath;

    if (media is MovieTrending) {
      title = (media as MovieTrending).title;
      date = (media as MovieTrending).releaseDate;
      posterPath = (media as MovieTrending).posterPath;
    } else if (media is TvTrending) {
      title = (media as TvTrending).name;
      date = (media as TvTrending).firstAirDate;
      posterPath = (media as TvTrending).posterPath;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.shortestSide * 0.36,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            placeholder: (context, url) {
              return AspectRatio(
                  aspectRatio: aspectRatio,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(child: CircularProgressIndicator())));
            },
            imageUrl: getImage(
              path: posterPath,
              size: 'w200',
            ),
            imageBuilder: (context, imageProvider) => AspectRatio(
              aspectRatio: aspectRatio,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Flexible(
            child: Visibility(
              visible: title != null,
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              child: Text(
                title ?? 'UNKNOWN',
                style: TextStyles.robotoMediumStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Flexible(
            child: Visibility(
              visible: date != null,
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              child: Text(
                date == null ? 'UNKNOWN' : DateFormat.yMMMd().format(date),
                style: TextStyles.robotoRegularStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
