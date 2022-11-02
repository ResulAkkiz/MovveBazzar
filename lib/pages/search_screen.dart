import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/base_trending_show_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';

import 'package:flutter_application_1/model/people_trending_model.dart';
import 'package:flutter_application_1/model/tv_trending_model.dart';
import 'package:flutter_application_1/pages/media_detail_screen.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final double posterAspectRatio = 10 / 16;
  TextEditingController controller = TextEditingController();
  List<TvTrending> queryTvList = [];
  List<MovieTrending> queryMovieList = [];
  List<PeopleTrending> queryPeopleList = [];

  int page = 1;
  String query = '';

  ScrollController tvScrollController = ScrollController();
  ScrollController movieScrollController = ScrollController();
  ScrollController peopleScrollController = ScrollController();
  @override
  void initState() {
    tvScrollController.addListener(pagination);
    movieScrollController.addListener(pagination);
    peopleScrollController.addListener(pagination);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaViewModel = Provider.of<MediaViewModel>(context);

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (value) async {
                        query = value;
                        mediaViewModel.queryResultList?.clear();
                        await mediaViewModel.searchQueries(
                            value, page.toString());
                      },
                      controller: controller,
                      cursorColor: Colors.red,
                      decoration: const InputDecoration(
                          hintText: 'Search',
                          contentPadding: EdgeInsets.fromLTRB(74, 12, 10, 12)),
                    ),
                    const CircleAvatar(
                      radius: 32,
                      child: Icon(
                        Icons.search_rounded,
                        size: 48,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: Theme.of(context).primaryColor,
              ),
              buildTitle('Tv Shows'),
              buildMediaListView(
                  mediaViewModel.queryTvList, tvScrollController),
              Divider(
                thickness: 2,
                color: Theme.of(context).primaryColor,
              ),
              buildTitle('Movies'),
              buildMediaListView(
                  mediaViewModel.queryMovieList, movieScrollController),
              Divider(
                thickness: 2,
                color: Theme.of(context).primaryColor,
              ),
              buildTitle('Actor & Actress '),
              buildMediaListView(
                  mediaViewModel.queryPeopleList, peopleScrollController),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildMediaListView(List<IBaseTrendingModel<dynamic>> mediaList,
      ScrollController scrollController) {
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
          controller: scrollController,
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
                        return MediaDetailPage(
                          currentMedia.id!,
                          mediaType: currentMedia.mediaType!,
                        );
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
    DateTime? date;
    String? posterPath;
    String? knownForDepartment;
    if (currentMedia is TvTrending) {
      date = currentMedia.firstAirDate;
      posterPath = currentMedia.posterPath;
    } else if (currentMedia is MovieTrending) {
      date = currentMedia.releaseDate;
      posterPath = currentMedia.posterPath;
    } else if (currentMedia is PeopleTrending) {
      posterPath = currentMedia.profilePath;
      knownForDepartment = currentMedia.knownForDepartment;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.shortestSide * 0.36,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (posterPath != null)
            CachedNetworkImage(
              placeholder: (context, url) {
                return Center(
                  child: SizedBox.square(
                    dimension: MediaQuery.of(context).size.shortestSide * 0.2,
                    child: const CircularProgressIndicator(),
                  ),
                );
              },
              imageUrl: getImage(path: posterPath, size: 'w200'),
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
          if (knownForDepartment != null)
            Flexible(
              child: Text(
                knownForDepartment,
                style: TextStyles.robotoRegularStyle,
              ),
            ),
          if (date != null)
            Flexible(
              child: Text(
                DateFormat.yMMMd().format(date),
                style: TextStyles.robotoRegularStyle,
              ),
            ),
        ],
      ),
    );
  }

  void pagination() {
    final mediaViewModel = Provider.of<MediaViewModel>(context, listen: false);

    if ((tvScrollController.position.pixels ==
            tvScrollController.position.maxScrollExtent) ||
        (movieScrollController.position.pixels ==
            movieScrollController.position.maxScrollExtent) ||
        (peopleScrollController.position.pixels ==
            peopleScrollController.position.maxScrollExtent)) {
      page += 1;
      mediaViewModel.searchQueries(query, page.toString());
    }
  }
}
