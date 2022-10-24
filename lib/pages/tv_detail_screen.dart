import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/palette_function.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:flutter_application_1/pages/tv/app_bar_widget.dart';
import 'package:flutter_application_1/pages/tv/cast_widget.dart';
import 'package:flutter_application_1/pages/tv/genres_widget.dart';
import 'package:flutter_application_1/pages/tv/media_widget.dart';
import 'package:flutter_application_1/pages/tv/reviews_widget.dart';
import 'package:flutter_application_1/pages/tv/seasons_widget.dart';
import 'package:flutter_application_1/pages/tv/showcase_widget.dart';
import 'package:flutter_application_1/pages/tv/similar_themes_widget.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class TvDetailPage extends StatefulWidget {
  const TvDetailPage(
      {super.key, required this.mediaID, required this.movierID});
  final int mediaID;
  final String movierID;

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  PaletteGenerator? palette;

  @override
  void initState() {
    debugPrint(widget.mediaID.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaViewModel mediaViewModel = context.read<MediaViewModel>();

    return FutureBuilder(
      future: mediaViewModel.getTvbyID(widget.mediaID),
      builder: (context, AsyncSnapshot<Tv> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (snapshot.hasData) {
          Tv tv = snapshot.data!;

          String url = getImage(
            path: tv.backdropPath,
            size: 'original',
          );
          ImageProvider image = CachedNetworkImageProvider(url);

          return loadContent(tv, image);
        }

        return const SplashScreen();
      },
    );
  }

  FutureBuilder<PaletteGenerator?> loadContent(Tv tv, ImageProvider image) {
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
              appBar: AppBarWidget(
                tv,
                palette: palette,
              ),
              backgroundColor: palette?.darkMutedColor?.color,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ShowcaseWidget(
                      tv,
                      image: image,
                      palette: palette,
                    ),
                    GenresWidget(
                      tv,
                      palette: palette,
                    ),
                    buildOverview(tv),
                    MediaWidget(tv),
                    CastWidget(tv),
                    ReviewsWidget(
                      tv,
                      palette: palette,
                    ),
                    SimilarThemesWidget(tv),
                    SeasonsWidget(
                      tv,
                      palette: palette,
                    ),
                  ],
                ),
              ),
            ),
            if (snapshot.connectionState == ConnectionState.waiting)
              buildLoader(),
          ],
        );
      },
    );
  }

  Stack buildLoader() {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: const Opacity(
            opacity: 0.8,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black,
            ),
          ),
        ),
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }

  Padding buildOverview(Tv tv) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        tv.overview ?? 'UNKNOWN OVERVIEW',
        style: TextStyles.robotoRegular19Style.copyWith(
          color: palette?.darkMutedColor?.bodyTextColor ??
              Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
