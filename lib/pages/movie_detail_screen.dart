import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/palette_function.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/model/movie_model.dart';
import 'package:flutter_application_1/pages/common/cast_widget.dart';
import 'package:flutter_application_1/pages/common/media_widget.dart';
import 'package:flutter_application_1/pages/common/reviews_widget.dart';
import 'package:flutter_application_1/pages/movie/movie_detail_appbar_widget.dart';

import 'package:flutter_application_1/pages/movie/movie_detail_genres_widget.dart';

import 'package:flutter_application_1/pages/movie/movie_detail_showcase_widget.dart';
import 'package:flutter_application_1/pages/movie/movie_detail_similiarthemes_widget.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';

import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import '../app_constants/common_function.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage(
      {super.key, required this.mediaID, required this.movierID});
  final int mediaID;
  final String movierID;
  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  PaletteGenerator? palette;

  @override
  void initState() {
    debugPrint(widget.mediaID.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaViewModel = Provider.of<MediaViewModel>(context);
    return FutureBuilder(
        future: context.read<MediaViewModel>().getMoviebyID(widget.mediaID),
        builder: (context, AsyncSnapshot<Movie> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            Movie movie = snapshot.data!;

            String url = getImage(
              path: movie.backdropPath,
              size: 'original',
            );
            ImageProvider image = CachedNetworkImageProvider(url);
            return loadContent(image, movie, mediaViewModel);
          } else {
            return const SplashScreen();
          }
        });
  }

  FutureBuilder<PaletteGenerator?> loadContent(
      ImageProvider image, Movie movie, MediaViewModel mediaViewModel) {
    return FutureBuilder(
        future: image.toPalette(
          size: const Size(150, 240),
        ),
        builder: (context, AsyncSnapshot<PaletteGenerator?> snapshot) {
          if (snapshot.hasData) {
            palette = snapshot.data!;
          }
          return Stack(
            children: [
              Scaffold(
                extendBodyBehindAppBar: true,
                appBar: MovieDetailAppBarWidget(
                  movie,
                  palette: palette,
                ),
                backgroundColor: palette?.darkMutedColor?.color,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      MovieDetailShowcaseWidget(
                        movie,
                        image: image,
                        palette: palette,
                      ),
                      MovieDetailGenresWidget(
                        movie,
                        palette: palette,
                      ),
                      buildOverview(movie),
                      MediaWidget(movie.id, 'movie'),
                      CastWidget(movie.id, 'movie'),
                      ReviewsWidget(
                        movie.id,
                        'movie',
                        palette: palette,
                      ),
                      MovieDetailSimiliarThemesWidget(movie),
                    ],
                  ),
                ),
              ),
              if (snapshot.connectionState == ConnectionState.waiting)
                buildLoader(),
            ],
          );
        });
  }

  Widget buildLoader() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: const Opacity(
        opacity: 0.8,
        child: ModalBarrier(
          dismissible: false,
          color: Colors.black,
        ),
      ),
    );
  }

  Padding buildOverview(Movie movie) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        movie.overview ?? 'UNKNOWN OVERVIEW',
        style: TextStyles.robotoRegular19Style.copyWith(
          color: palette?.darkMutedColor?.bodyTextColor ??
              Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
