import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:flutter_application_1/model/tv_trending_model.dart';
import 'package:flutter_application_1/pages/tv_detail_screen.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:flutter_application_1/viewmodel/movier_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SimilarThemesWidget extends StatefulWidget {
  final Tv tv;

  const SimilarThemesWidget(this.tv, {Key? key}) : super(key: key);

  @override
  State<SimilarThemesWidget> createState() => _SimilarThemesWidgetState();
}

class _SimilarThemesWidgetState extends State<SimilarThemesWidget> {
  late final Tv tv = widget.tv;

  final double filmAspectRatio = 10 / 16;

  @override
  void initState() {
    super.initState();

    context.read<MediaViewModel>().getSimilarTvbyTvIDs(tv.id!);
  }

  @override
  Widget build(BuildContext context) {
    final MovierViewModel movierViewModel = context.read<MovierViewModel>();
    final MediaViewModel mediaViewModel = context.read<MediaViewModel>();
    final List<TvTrending> similiarTvList = mediaViewModel.similiarTvList;

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
              itemCount: similiarTvList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                var currentMedia = similiarTvList[index];
                return InkWell(
                  child: buildMediaClip(currentMedia),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TvDetailPage(
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

  Widget buildMediaClip(TvTrending currentMedia) {
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
              currentMedia.name ?? 'UNKNOWN',
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
              currentMedia.firstAirDate == null
                  ? 'UNKNOWN'
                  : DateFormat.yMMMd().format(currentMedia.firstAirDate!),
              style: TextStyles.robotoRegularStyle,
            ),
          ),
        ],
      ),
    );
  }
}
