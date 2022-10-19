import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/pages/movie_detail_screen.dart';
import 'package:flutter_application_1/pages/more_trends_screen.dart';
import 'package:flutter_application_1/pages/tv_detail_screen.dart';
import 'package:flutter_application_1/services/base_service.dart';
import 'package:flutter_application_1/services/firebase_db_service.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomepageBody extends StatefulWidget {
  const HomepageBody({Key? key}) : super(key: key);

  @override
  State<HomepageBody> createState() => _HomepageBodyState();
}

class _HomepageBodyState extends State<HomepageBody> {
  BaseService baseService = BaseService();
  late final MediaViewModel mediaViewModel = context.read();
  final double posterAspectRatio = 10 / 16;

  @override
  void initState() {
    getStarted();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaViewModel mediaViewModel = Provider.of<MediaViewModel>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        bottom: 64.0 + 20.0 + 15.0,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildTopic(
              value: 'Popular Movies',
              trailingWidget: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MoreTrendScreen(
                      items: mediaViewModel.trendingModelList,
                    ),
                  ));
                },
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  visualDensity: VisualDensity.compact,
                ),
                child: Text(
                  'see more...',
                  style: TextStyles.robotoRegular10Style,
                ),
              ),
            ),
            buildMediaListView(mediaViewModel.popularMovieModelList),
            BuildTopic(
              value: 'Popular Tv Shows',
              trailingWidget: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MoreTrendScreen(
                      items: mediaViewModel.trendingModelList,
                    ),
                  ));
                },
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  visualDensity: VisualDensity.compact,
                ),
                child: Text(
                  'see more...',
                  style: TextStyles.robotoRegular10Style,
                ),
              ),
            ),
            buildMediaListView(mediaViewModel.popularTvModelList),
            BuildTopic(
              value: 'Trends',
              trailingWidget: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MoreTrendScreen(
                      items: mediaViewModel.trendingModelList,
                    ),
                  ));
                },
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  visualDensity: VisualDensity.compact,
                ),
                child: Text(
                  'see more...',
                  style: TextStyles.robotoRegular10Style,
                ),
              ),
            ),
            buildMediaListView(mediaViewModel.trendingModelList),
            const BuildTopic(value: 'Discover Movies'),
            buildMediaListView(mediaViewModel.discoverMovieModelList),
            const BuildTopic(value: 'Discover Tv Shows'),
            buildMediaListView(mediaViewModel.discoverTvModelList),
          ],
        ),
      ),
    );
  }

  Widget buildMediaListView(List<IBaseTrendingModel<dynamic>> mediaList) {
    return SizedBox(
      height: (MediaQuery.of(context).size.shortestSide *
              0.36 /
              posterAspectRatio) +
          64.0,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: ListView.separated(
          itemCount: mediaList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            IBaseTrendingModel currentMedia = mediaList[index];
            return InkWell(
                child: buildMediaClip(currentMedia),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return currentMedia.mediaType == 'tv'
                            ? TvDetailPage(mediaID: currentMedia.id!)
                            : MovieDetailPage(mediaID: currentMedia.id!);
                      },
                    ),
                  );
                });
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
    );
  }

  Widget buildMediaClip(IBaseTrendingModel<dynamic> currentMedia) {
    return SizedBox(
      width: MediaQuery.of(context).size.shortestSide * 0.36,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: getImage(path: currentMedia.posterPath, size: 'w200'),
            imageBuilder: (context, imageProvider) => AspectRatio(
              aspectRatio: posterAspectRatio,
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
              currentMedia.mediaName ?? 'UNKNOWN',
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
              currentMedia.date == null
                  ? 'UNKNOWN'
                  : DateFormat.yMMMd().format(currentMedia.date!),
              style: TextStyles.robotoRegularStyle,
            ),
          ),
        ],
      ),
    );
  }

  void getStarted() {
    mediaViewModel.getTrendings(
      type: 'all',
      timeInterval: 'day',
      pageNumber: 1,
    );
    FirebaseDbService firebaseDbService = FirebaseDbService();
    firebaseDbService.getBookMarks('VL4rbNj93caIzdDBY3CNDm859Yl2');
    mediaViewModel.getTvPopulars(pageNumber: 1);
    mediaViewModel.getMoviePopulars(pageNumber: 1);
    mediaViewModel.getDiscovers(type: 'movie', pageNumber: 1);
    mediaViewModel.getDiscovers(type: 'tv', pageNumber: 1);
  }
}

class BuildTopic extends StatelessWidget {
  final String value;
  final Widget? trailingWidget;

  const BuildTopic({
    Key? key,
    required this.value,
    this.trailingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
      child: SizedBox(
        height: TextStyles.robotoHeadlineStyle.fontSize! * 1.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                value,
                style: TextStyles.robotoHeadlineStyle,
              ),
            ),
            if (trailingWidget != null) Flexible(child: trailingWidget!),
          ],
        ),
      ),
    );
  }
}
