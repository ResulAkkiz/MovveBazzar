import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/model/base_show_model.dart';
import 'package:flutter_application_1/model/movie_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';
import 'package:flutter_application_1/pages/common/media_clip_widget.dart';
import 'package:flutter_application_1/pages/media_detail_screen.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:provider/provider.dart';

class MovieDetailSimiliarThemesWidget extends StatefulWidget {
  final IBaseShowModel movie;

  const MovieDetailSimiliarThemesWidget(this.movie, {Key? key})
      : super(key: key);

  @override
  State<MovieDetailSimiliarThemesWidget> createState() =>
      _MovieDetailSimiliarThemesWidgetState();
}

class _MovieDetailSimiliarThemesWidgetState
    extends State<MovieDetailSimiliarThemesWidget> {
  late final IBaseShowModel movie = widget.movie;

  final double aspectRatio = 10 / 16;

  @override
  void initState() {
    super.initState();

    context.read<MediaViewModel>().getSimilarMoviebyMovieIDs(movie.id);
  }

  @override
  Widget build(BuildContext context) {
    final MediaViewModel mediaViewModel = context.watch<MediaViewModel>();
    final List<MovieTrending> similiarMovieList =
        mediaViewModel.similiarMovieList;

    return similiarMovieList.isEmpty
        ? const SizedBox.shrink()
        : Column(
            children: [
              buildTitle('Similar Themes'),
              SizedBox(
                height: (MediaQuery.of(context).size.shortestSide *
                        0.36 /
                        aspectRatio) +
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
                        child: MediaClipWidget(
                          currentMedia,
                          aspectRatio: aspectRatio,
                        ),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MediaDetailPage(
                              currentMedia.id!,
                              mediaType: 'movie',
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
}
