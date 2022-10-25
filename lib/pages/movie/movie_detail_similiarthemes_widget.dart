import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/model/movie_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';
import 'package:flutter_application_1/pages/movie_detail_screen.dart';

import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../app_constants/common_function.dart';
import '../../app_constants/text_styles.dart';
import '../../viewmodel/movier_view_model.dart';

class MovieDetailSimiliarThemesWidget extends StatefulWidget {
  final Movie movie;

  const MovieDetailSimiliarThemesWidget(this.movie, {Key? key})
      : super(key: key);

  @override
  State<MovieDetailSimiliarThemesWidget> createState() =>
      _MovieDetailSimiliarThemesWidgetState();
}

class _MovieDetailSimiliarThemesWidgetState
    extends State<MovieDetailSimiliarThemesWidget> {
  late final Movie movie = widget.movie;

  final double filmAspectRatio = 10 / 16;

  @override
  void initState() {
    super.initState();

    context.read<MediaViewModel>().getSimilarMoviebyMovieIDs(movie.id);
  }

  @override
  Widget build(BuildContext context) {
    final MovierViewModel movierViewModel = context.read<MovierViewModel>();
    final MediaViewModel mediaViewModel = context.watch<MediaViewModel>();
    final List<MovieTrending> similiarMovieList =
        mediaViewModel.similiarMovieList;

    return Column(
      children: [
        buildTitle('Similar Themes'),
        SizedBox(
          height: (MediaQuery.of(context).size.shortestSide *
                  0.36 /
                  filmAspectRatio) +
              64.0,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return false;
            },
            child: ListView.separated(
              itemCount: similiarMovieList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                var currentMedia = similiarMovieList[index];
                return InkWell(
                  child: buildMediaClip(currentMedia),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(
                        mediaID: currentMedia.id!,
                        movierID: movierViewModel.movier!.movierID,
                      ),
                    ),
                  ),
                );
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              separatorBuilder: (context, index) => const SizedBox(
                width: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMediaClip(MovieTrending currentMedia) {
    return SizedBox(
      width: MediaQuery.of(context).size.shortestSide * 0.36,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: getImage(
              path: currentMedia.posterPath,
              size: 'w200',
            ),
            imageBuilder: (context, imageProvider) => AspectRatio(
              aspectRatio: filmAspectRatio,
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
            child: Text(
              currentMedia.title ?? 'UNKNOWN',
              style: TextStyles.robotoMediumStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Flexible(
            child: Text(
              currentMedia.releaseDate == null
                  ? 'UNKNOWN'
                  : DateFormat.yMMMd().format(currentMedia.releaseDate!),
              style: TextStyles.robotoRegularStyle,
            ),
          ),
        ],
      ),
    );
  }
}
