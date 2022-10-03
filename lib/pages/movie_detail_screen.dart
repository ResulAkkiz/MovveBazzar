import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';

import 'package:flutter_application_1/model/movie_model.dart';
import 'package:flutter_application_1/model/people_cast_model.dart';
import 'package:flutter_application_1/model/people_model.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../app_constants/common_function.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.mediaID});
  final int mediaID;
  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  double posterAspectRatio = 6 / 5;
  @override
  void initState() {
    context.read<MediaViewModel>().getCastbyMovieIds(widget.mediaID);
    context
        .read<MediaViewModel>()
        .getMediaImagebyMediaID(widget.mediaID, 'movie');
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
            List<Widget> imageWidgetList = [];

            if (mediaViewModel.mediaImageList != null) {
              for (var element in mediaViewModel.mediaImageList!) {
                imageWidgetList.add(
                  Center(
                    child: CachedNetworkImage(
                      placeholder: (context, url) {
                        return Center(
                          child: SizedBox(
                            width: 250,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) => Icon(
                          Icons.question_mark,
                          size: 60,
                          color: Theme.of(context).primaryColor),
                      imageUrl: getImage(
                          path: element.filePath ?? '', size: 'original'),
                      imageBuilder: (context, imageProvider) => AspectRatio(
                        aspectRatio: element.aspectRatio ?? 16 / 9,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: _buildDetailAppBar(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        CachedNetworkImage(
                          placeholder: (context, url) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          imageUrl: getImage(
                              path: currentMovie.backdropPath ?? '',
                              size: 'original'),
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
                        ),
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
                                    currentMovie.title ?? 'UNKOWN',
                                    style: TextStyles.robotoBoldStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  '${currentMovie.releaseDate!.year} , Runtime: ${currentMovie.runtime} min',
                                  style: TextStyles.robotoRegular16Style,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      currentMovie.voteAverage!
                                          .toStringAsFixed(1),
                                      style: TextStyles.robotoMedium18Style
                                          .copyWith(
                                              color: const Color(0xFFFDC432)),
                                    ),
                                    RatingBar(
                                      ignoreGestures: true,
                                      itemSize: 20,
                                      initialRating:
                                          currentMovie.voteAverage! / 2,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      onRatingUpdate: (rating) {},
                                      ratingWidget: RatingWidget(
                                        full: IconEnums.fullstar.toImage,
                                        half: IconEnums.halfstar.toImage,
                                        empty: IconEnums.emptystar.toImage,
                                      ),
                                    ),
                                    Text(
                                      '(${currentMovie.voteCount!.toStringAsFixed(1)})',
                                      style: TextStyles.robotoRegular10Style
                                          .copyWith(
                                        color: Colors.white.withOpacity(0.4),
                                      ),
                                    ),
                                  ],
                                ),
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
                        SizedBox(
                          width: double.infinity,
                          height: 275,
                          child: ListWheelScrollView(
                            squeeze: 1.5,
                            itemExtent: 275,
                            children: imageWidgetList,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Cast',
                            style: TextStyles.robotoMedium18Style,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: MediaQuery.of(context).size.width / 3,
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
                        )
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

  AppBar _buildDetailAppBar() {
    return AppBar(
      leading: IconButton(
        icon: IconEnums.backarrow.toImage,
        onPressed: () {},
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(onPressed: () {}, icon: IconEnums.bookmark.toImage),
      ],
    );
  }

  void getCastList(int mediaID) async {
    final mediaViewModel = Provider.of<MediaViewModel>(context);
    await mediaViewModel.getCastbyMovieIds(mediaID);
  }
}
