import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/palette_function.dart';
import 'package:flutter_application_1/model/base_model.dart';
import 'package:flutter_application_1/model/base_show_model.dart';
import 'package:flutter_application_1/model/movie_model.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:flutter_application_1/pages/common/app_bar_widget.dart';
import 'package:flutter_application_1/pages/common/cast_widget.dart';
import 'package:flutter_application_1/pages/common/genres_widget.dart';
import 'package:flutter_application_1/pages/common/loader_widget.dart';
import 'package:flutter_application_1/pages/common/media_widget.dart';
import 'package:flutter_application_1/pages/common/overview_widget.dart';
import 'package:flutter_application_1/pages/common/reviews_widget.dart';
import 'package:flutter_application_1/pages/common/showcase_widget.dart';
import 'package:flutter_application_1/pages/movie/movie_detail_similiarthemes_widget.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:flutter_application_1/pages/tv/seasons_widget.dart';
import 'package:flutter_application_1/pages/tv/similar_themes_widget.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class MediaDetailPage extends StatefulWidget {
  final int mediaID;
  final String mediaType;

  const MediaDetailPage(
    this.mediaID, {
    super.key,
    required this.mediaType,
  });

  @override
  State<MediaDetailPage> createState() => _MediaDetailPageState();
}

class _MediaDetailPageState extends State<MediaDetailPage> {
  PaletteGenerator? palette;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaViewModel mediaViewModel = context.read<MediaViewModel>();

    return FutureBuilder<IBaseModel>(
      future: mediaViewModel.getDetailbyID(widget.mediaID, widget.mediaType),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (snapshot.hasData) {
          IBaseModel media = snapshot.data!;

          return loadContent(media);
        }

        return const SplashScreen();
      },
    );
  }

  FutureBuilder<PaletteGenerator?> loadContent(IBaseModel media) {
    String url = getImage(
      path: media is IBaseShowModel ? media.backdropPath : media.posterPath,
      size: 'w300',
    );
    ImageProvider image = CachedNetworkImageProvider(url);

    return FutureBuilder(
      future: image.toPalette(
        size: const Size(80, 128),
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
                media,
                palette: palette,
              ),
              backgroundColor: palette?.darkMutedColor?.color,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    if (media is IBaseShowModel)
                      ShowcaseWidget(
                        media,
                        image: image,
                        palette: palette,
                      ),
                    if (media is IBaseShowModel)
                      GenresWidget(
                        media,
                        palette: palette,
                      ),
                    OverviewWidget(media),
                    MediaWidget(media.id, widget.mediaType),
                    CastWidget(media.id, widget.mediaType),
                    ReviewsWidget(
                      media.id,
                      widget.mediaType,
                      palette: palette,
                    ),
                    widget.mediaType == 'tv'
                        ? SimilarThemesWidget(media as Tv)
                        : MovieDetailSimiliarThemesWidget(media as Movie),
                    if (widget.mediaType == 'tv')
                      SeasonsWidget(
                        media as Tv,
                        palette: palette,
                      ),
                  ],
                ),
              ),
            ),
            if (snapshot.connectionState == ConnectionState.waiting)
              const LoaderWidget(),
          ],
        );
      },
    );
  }
}
