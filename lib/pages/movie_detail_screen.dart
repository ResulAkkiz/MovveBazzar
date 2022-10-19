import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/model/bookmark_model.dart';
import 'package:flutter_application_1/model/media_base_model.dart';
import 'package:flutter_application_1/model/media_images_model.dart';
import 'package:flutter_application_1/model/media_videos_model.dart';

import 'package:flutter_application_1/model/movie_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';
import 'package:flutter_application_1/model/people_cast_model.dart';
import 'package:flutter_application_1/model/review_model.dart';

import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:flutter_application_1/viewmodel/bookmark_view_model.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../app_constants/common_function.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.mediaID});
  final int mediaID;
  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  double posterAspectRatio = 7 / 6;
  double filmAspectRatio = 10 / 16;
  @override
  void initState() {
    debugPrint(widget.mediaID.toString());
    context.read<MediaViewModel>().getCastbyMediaIDs(widget.mediaID, 'movie');
    context.read<MediaViewModel>().getMediasbyMediaID(widget.mediaID, 'movie');
    context.read<MediaViewModel>().getSimilarMoviebyMovieIDs(widget.mediaID);
    context
        .read<MediaViewModel>()
        .getReviewsbyMediaID(widget.mediaID, 1, 'movie');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaViewModel = Provider.of<MediaViewModel>(context);
    return FutureBuilder(
        future: context.read<MediaViewModel>().getMoviebyID(widget.mediaID),
        builder: (context, AsyncSnapshot<Movie> snapshot) {
          if (snapshot.hasData) {
            Movie currentMovie = snapshot.data!;
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: _buildDetailAppBar(currentMovie),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        buildBackDropImage(currentMovie),
                        Positioned(
                          bottom: -2,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.5,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Theme.of(context).scaffoldBackgroundColor,
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
                                    currentMovie.title ?? 'UNKNOWN',
                                    style: TextStyles.robotoBoldStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  '${currentMovie.releaseDate!.year} , Runtime: ${currentMovie.runtime} min',
                                  style: TextStyles.robotoRegular16Style,
                                ),
                                buildRatingBar(currentMovie),
                              ],
                            ).separated(
                              const SizedBox(
                                height: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.shortestSide * 0.15,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: currentMovie.genres!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Chip(
                              label: Text(
                                currentMovie.genres![index].name ?? '',
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          );
                        },
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            currentMovie.overview ?? 'UNKNOWN OVERVIEW',
                            style: TextStyles.robotoRegular19Style
                                .copyWith(color: Colors.white.withOpacity(0.5)),
                          ),
                        ),
                        mediaViewModel.mediaList != []
                            ? SizedBox(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.7,
                                child: PageView.builder(
                                  itemCount: mediaViewModel.mediaList?.length,
                                  itemBuilder: (context, index) {
                                    MediaBase currentMedia =
                                        mediaViewModel.mediaList![index];
                                    if (currentMedia is MediaImage) {
                                      return SizedBox(
                                        height: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.7,
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => Center(
                                            child: SizedBox(
                                              width: 175,
                                              child: CircularProgressIndicator(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                          imageUrl: getImage(
                                              path: currentMedia.filePath!,
                                              size: 'original'),
                                        ),
                                      );
                                    } else if (currentMedia is MediaVideo) {
                                      return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide *
                                              0.7,
                                          child: YoutubePlayer(
                                            controller: YoutubePlayerController(
                                                flags: const YoutubePlayerFlags(
                                                    autoPlay: true,
                                                    mute: true,
                                                    disableDragSeek: true),
                                                initialVideoId: YoutubePlayer
                                                    .convertUrlToId(
                                                        'https://www.youtube.com/watch?v=${currentMedia.key}')!),
                                          ));
                                    } else {
                                      return const Center(
                                          child: SizedBox.square(
                                              dimension: 50,
                                              child: Icon(Icons.warning)));
                                    }
                                  },
                                ),
                              )
                            : const SizedBox(),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.centerLeft,
                          child: Text('Cast',
                              style: TextStyles.robotoMedium30Style),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height:
                              MediaQuery.of(context).size.shortestSide / 3.3,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemExtent: 80,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: mediaViewModel.peopleCastList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _buildCastColumn(
                                      mediaViewModel.peopleCastList[index])
                                  .separated(const SizedBox(
                                height: 5,
                              ));
                            },
                          ),
                        ),
                        buildReviewPart(context),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: Text('Similar Themes',
                              style: TextStyles.robotoMedium30Style),
                        ),
                        buildMediaListView(mediaViewModel.similiarMovieList)
                      ],
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const SplashScreen();
          }
        });
  }

  Widget buildMediaListView(List<MovieTrending> similiarMovieList) {
    return SizedBox(
      height:
          (MediaQuery.of(context).size.shortestSide * 0.36 / filmAspectRatio) +
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
                        builder: (context) =>
                            MovieDetailPage(mediaID: currentMedia.id!),
                      ),
                    ));
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

  Widget buildMediaClip(MovieTrending currentMedia) {
    return SizedBox(
      width: MediaQuery.of(context).size.shortestSide * 0.36,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: getImage(path: currentMedia.posterPath, size: 'w200'),
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

  Widget buildReviewPart(BuildContext context) {
    var mediaVideoModel = Provider.of<MediaViewModel>(context);

    return mediaVideoModel.reviewList.isNotEmpty
        ? Container(
            height: MediaQuery.of(context).size.shortestSide * 0.9,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10)),
            child: PageView.builder(
                itemCount: mediaVideoModel.reviewList.length,
                itemBuilder: (context, index) {
                  Review currentReview = mediaVideoModel.reviewList[index];

                  return Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      Positioned(
                          left: 20,
                          child: Container(
                            width: (MediaQuery.of(context).size.shortestSide *
                                    0.33) -
                                20,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.75,
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                      Positioned(
                          left: 10,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.33,
                                height:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.6,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(2)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 25, 10, 32),
                                  child: Column(
                                    children: [
                                      AspectRatio(
                                          aspectRatio: 1,
                                          child: CachedNetworkImage(
                                              errorWidget:
                                                  (context, url, error) {
                                                return const Icon(
                                                  Icons.dangerous,
                                                );
                                              },
                                              imageUrl: currentReview
                                                          .authorDetails!
                                                          .avatarPath !=
                                                      null
                                                  ? (currentReview
                                                          .authorDetails!
                                                          .avatarPath!
                                                          .startsWith(
                                                              '/https://www')
                                                      ? currentReview
                                                          .authorDetails!
                                                          .avatarPath!
                                                          .substring(1)
                                                      : getImage(
                                                          path: currentReview
                                                              .authorDetails!
                                                              .avatarPath!,
                                                          size: 'original'))
                                                  : getImage(
                                                      path:
                                                          'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=1060&t=st=1665151999~exp=1665152599~hmac=7ed5078bf5502eaefe2f23995ac6a2004ee9c97a62a98084e2e094cdf6178abd',
                                                      size: ''))),
                                      Text(
                                        currentReview.author ?? '',
                                        style: TextStyles.robotoBold18Style
                                            .copyWith(color: Colors.black87),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.8,
                                width: MediaQuery.of(context).size.width -
                                    (MediaQuery.of(context).size.shortestSide *
                                            0.33 +
                                        40),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Reviews',
                                        style:
                                            TextStyles.robotoRegularBold24Style,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        currentReview.content!,
                                        overflow: TextOverflow.fade,
                                        style: TextStyles.robotoRegular10Style,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  );
                }))
        : const SizedBox();
  }

  CachedNetworkImage buildBackDropImage(Movie currentMovie) {
    return CachedNetworkImage(
      placeholder: (context, url) {
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      imageUrl:
          getImage(path: currentMovie.backdropPath ?? '', size: 'original'),
      imageBuilder: (context, imageProvider) {
        return AspectRatio(
            aspectRatio: posterAspectRatio,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ));
      },
    );
  }

  Row buildRatingBar(Movie currentMovie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          currentMovie.voteAverage!.toStringAsFixed(1),
          style: TextStyles.robotoMedium18Style
              .copyWith(color: const Color(0xFFFDC432)),
        ),
        RatingBar(
          ignoreGestures: true,
          itemSize: 20,
          initialRating: currentMovie.voteAverage! / 2,
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
          '(${currentMovie.voteCount!.toStringAsFixed(1)})',
          style: TextStyles.robotoRegular10Style.copyWith(
            color: Colors.white.withOpacity(0.4),
          ),
        ),
      ],
    );
  }

  Column _buildCastColumn(PeopleCast people) {
    return Column(
      children: [
        ClipOval(
          child: people.profilePath != null
              ? CachedNetworkImage(
                  width: 60,
                  height: 60,
                  imageUrl: getImage(
                      path: people.profilePath ?? '', size: 'original'),
                )
              : CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  child: ImageEnums.celebrity.toImage,
                ),
        ),
        Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          people.name ?? 'UNKNOWN',
          softWrap: true,
          style: TextStyles.robotoRegular10Style,
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
          people.character ?? 'UNKNOWN',
          style: TextStyles.robotoRegular10Style
              .copyWith(color: Colors.white.withOpacity(0.6)),
        )
      ],
    );
  }

  AppBar _buildDetailAppBar(Movie currentMovie) {
    BookmarkViewModel bookmarkViewModel =
        Provider.of<BookmarkViewModel>(context);
    return AppBar(
      leading: IconButton(
        icon: IconEnums.backarrow.toImage,
        onPressed: () {},
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {
              bookmarkViewModel.saveBookMarks(
                BookMark(
                    runtime: currentMovie.runtime,
                    date: currentMovie.releaseDate,
                    mediaType: 'movie',
                    mediaVote: currentMovie.voteAverage,
                    mediaID: currentMovie.id,
                    mediaName: currentMovie.title ?? '',
                    imagePath: currentMovie.posterPath ?? ''),
              );
            },
            icon: IconEnums.bookmark.toImage),
      ],
    );
  }
}
