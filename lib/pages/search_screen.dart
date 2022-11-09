import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';
import 'package:flutter_application_1/model/people_model.dart';

import 'package:flutter_application_1/model/people_trending_model.dart';
import 'package:flutter_application_1/model/tv_trending_model.dart';
import 'package:flutter_application_1/pages/media_detail_screen.dart';
import 'package:flutter_application_1/pages/person_detail_screen.dart';
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

  int pagePerson = 1;
  int pageMovie = 1;
  int pageTv = 1;
  String query = '';
  String type = 'multi';
  bool isCheckMovie = false;
  bool isCheckTv = false;
  bool isCheckActor = false;
  bool isCheckMulti = true;

  ScrollController tvScrollController =
      ScrollController(initialScrollOffset: 0.0);
  ScrollController movieScrollController = ScrollController();
  ScrollController peopleScrollController =
      ScrollController(initialScrollOffset: 0.0);
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
    // 'resultList: ${mediaViewModel.queryResultList!.length}'.log();
    // 'queryTvList: ${mediaViewModel.queryTvList.length}'.log();
    // 'queryMovieList: ${mediaViewModel.queryMovieList.length}'.log();
    // 'queryPeopleList: ${mediaViewModel.queryPeopleList.length}'.log();
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
                      onChanged: (value) {
                        query = value;
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
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 2)),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 15,
                        runSpacing: 10,
                        children: [
                          buildCheckBox(
                            context,
                            labelText: 'Movie',
                            value: isCheckMovie,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckMovie = value ?? false;
                                checkMulti();
                              });
                            },
                          ),
                          buildCheckBox(
                            context,
                            labelText: 'Tv Show',
                            value: isCheckTv,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckTv = value ?? false;
                                checkMulti();
                              });
                            },
                          ),
                          buildCheckBox(context, labelText: 'Actor/Actress',
                              onChanged: (bool? value) {
                            setState(() {
                              isCheckActor = value ?? false;
                              checkMulti();
                            });
                          }, value: isCheckActor),
                          buildCheckBox(
                            context,
                            labelText: 'Multi',
                            value: isCheckMulti,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckMulti = value!;
                                if (value) {
                                  isCheckActor = !value;
                                  isCheckMovie = !value;
                                  isCheckTv = !value;
                                }
                                checkMulti();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(12)),
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: IconButton(
                          onPressed: () {
                            resetSearch();

                            controlChecks();
                          },
                          icon: const Icon(Icons.search),
                          iconSize: 45,
                        ))
                  ],
                ),
              ),
              Column(
                children: [
                  if ((isCheckMovie || isCheckMulti) &&
                      mediaViewModel.queryMovieList.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 2)),
                      child: Column(
                        children: [
                          buildTitle('Movies'),
                          buildMediaListView(mediaViewModel.queryMovieList,
                              movieScrollController, 'movie'),
                        ],
                      ),
                    ),
                  if ((isCheckTv || isCheckMulti) &&
                      mediaViewModel.queryTvList.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 2)),
                      child: Column(
                        children: [
                          buildTitle('Tv Shows'),
                          buildMediaListView(mediaViewModel.queryTvList,
                              tvScrollController, 'tv'),
                        ],
                      ),
                    ),
                  if ((isCheckActor || isCheckMulti) &&
                      mediaViewModel.queryPeopleList.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 2)),
                      child: Column(
                        children: [
                          buildTitle('Actor & Actress '),
                          buildMediaListView(mediaViewModel.queryPeopleList,
                              peopleScrollController, 'person'),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  void pagination() async {
    final mediaViewModel = Provider.of<MediaViewModel>(context, listen: false);
    if (movieScrollController.hasClients) {
      if (movieScrollController.position.pixels ==
          movieScrollController.position.maxScrollExtent) {
        pageMovie++;
        type = 'movie';
        await mediaViewModel.searchQueries(query, pageMovie.toString(), type);
      }
    }
    if (tvScrollController.hasClients) {
      if (tvScrollController.position.pixels ==
          tvScrollController.position.maxScrollExtent) {
        pageTv++;
        type = 'tv';
        await mediaViewModel.searchQueries(query, pageTv.toString(), type);
      }
    }
    if (peopleScrollController.hasClients) {
      if (peopleScrollController.position.pixels ==
          peopleScrollController.position.maxScrollExtent) {
        pagePerson++;
        type = 'person';
        await mediaViewModel.searchQueries(query, pagePerson.toString(), type);
      }
    }
  }

  void checkMulti() {
    if (isCheckActor && isCheckMovie && isCheckTv) {
      isCheckMulti = true;
      isCheckActor = false;
      isCheckMovie = false;
      isCheckTv = false;
    } else if ((isCheckActor || isCheckMovie || isCheckTv)) {
      isCheckMulti = false;
    } else if (!isCheckActor && !isCheckMovie && !isCheckTv) {
      isCheckMulti = true;
      isCheckActor = false;
      isCheckMovie = false;
      isCheckTv = false;
    } else {
      isCheckMulti = false;
    }
  }

  void controlChecks() async {
    final mediaViewModel = Provider.of<MediaViewModel>(context, listen: false);
    if (isCheckMulti) {
      debugPrint('**************Multi içindeyim**************');
      await mediaViewModel.searchQueries(
          query, pagePerson.toString(), 'person');
      await mediaViewModel.searchQueries(query, pageMovie.toString(), 'movie');
      await mediaViewModel.searchQueries(query, pageTv.toString(), 'tv');
    } else {
      '*************else içindeyim*****************'.log();
      if (isCheckActor) {
        type = 'person';
        await mediaViewModel.searchQueries(query, pagePerson.toString(), type);
      }
      if (isCheckMovie) {
        type = 'movie';
        await mediaViewModel.searchQueries(query, pageMovie.toString(), type);
      }
      if (isCheckTv) {
        type = 'tv';
        await mediaViewModel.searchQueries(query, pageTv.toString(), type);
      }
    }
  }

  void resetSearch() {
    final mediaViewModel = Provider.of<MediaViewModel>(context, listen: false);
    if (movieScrollController.hasClients) {
      movieScrollController.jumpTo(0.0);
    }
    if (tvScrollController.hasClients) {
      tvScrollController.jumpTo(0.0);
    }
    if (peopleScrollController.hasClients) {
      peopleScrollController.jumpTo(0.0);
    }

    pageMovie = 1;
    pagePerson = 1;
    pageTv = 1;
    mediaViewModel.queryResultList?.clear();
  }

  Row buildCheckBox(BuildContext context,
      {bool? value,
      required String labelText,
      required void Function(bool?)? onChanged}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: Checkbox(
              value: value,
              activeColor: Theme.of(context).primaryColor,
              onChanged: onChanged),
        ),
        Text(labelText),
      ],
    );
  }

  Widget buildMediaListView(List<IBaseTrendingModel<dynamic>> mediaList,
      ScrollController scrollController, String mediaType) {
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
                        return currentMedia is PeopleTrending
                            ? PersonDetailScreen(
                                personID: currentMedia.id!,
                              )
                            : MediaDetailPage(
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
    String? type;
    if (currentMedia is TvTrending) {
      date = currentMedia.firstAirDate;
      posterPath = currentMedia.posterPath;
      type = 'tv';
    } else if (currentMedia is MovieTrending) {
      date = currentMedia.releaseDate;
      posterPath = currentMedia.posterPath;
      type = 'movie';
    } else if (currentMedia is PeopleTrending) {
      posterPath = currentMedia.profilePath;
      knownForDepartment = currentMedia.knownForDepartment;
      type = 'person';
    }

    return SizedBox(
      width: MediaQuery.of(context).size.shortestSide * 0.36,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            placeholder: (context, url) {
              return AspectRatio(
                aspectRatio: posterAspectRatio,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            imageUrl: getImageWithType(
                path: posterPath, size: 'w200', type: type ?? 'movie'),
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
}
