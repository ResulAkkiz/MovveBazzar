import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/base_model.dart';
import 'package:flutter_application_1/model/base_show_model.dart';
import 'package:flutter_application_1/model/bookmark_model.dart';
import 'package:flutter_application_1/model/movie_model.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:flutter_application_1/viewmodel/bookmark_view_model.dart';
import 'package:flutter_application_1/viewmodel/movier_view_model.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final IBaseModel media;
  final PaletteGenerator? palette;

  @override
  final Size preferredSize;

  const AppBarWidget(
    this.media, {
    Key? key,
    this.palette,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  late IBaseModel media = widget.media;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookmarkViewModel>().searchingBookmark(media.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final MovierViewModel movierViewModel = context.read<MovierViewModel>();
    final BookmarkViewModel bookmarkViewModel =
        context.watch<BookmarkViewModel>();
    final PaletteGenerator? palette = widget.palette;

    return AppBar(
      leading: IconButton(
        icon: CircleAvatar(
          radius: 16.0,
          backgroundColor:
              palette?.darkMutedColor?.color.withOpacity(0.4) ?? Colors.black38,
          foregroundColor: palette?.lightVibrantColor?.color,
          child: const Icon(Icons.chevron_left),
        ),
        onPressed: () {
          Navigator.of(context).maybePop();
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        if (media is IBaseShowModel)
          IconButton(
            onPressed: () {
              String? title;
              int? runtime;
              DateTime? date;

              if (media is Movie) {
                title = (media as Movie).title;
                runtime = (media as Movie).runtime;
                date = (media as Movie).releaseDate;
              } else if (media is Tv) {
                title = (media as Tv).name;
                if ((media as Tv).episodeRunTime?.isNotEmpty ?? false) {
                  runtime = (media as Tv).episodeRunTime?.first;
                }
                date = (media as Tv).firstAirDate;
              }

              bookmarkViewModel.isBookmarked
                  ? bookmarkViewModel.deleteBookmark(
                      movierViewModel.movier!.movierID, media.id)
                  : bookmarkViewModel.saveBookMarks(
                      movierViewModel.movier!.movierID,
                      BookMark(
                        runtime: runtime,
                        date: date,
                        mediaType: 'tv',
                        mediaID: media.id,
                        mediaVote: (media as IBaseShowModel).voteAverage,
                        mediaName: title ?? '',
                        imagePath: media.posterPath,
                      ),
                    );
            },
            icon: CircleAvatar(
              radius: 16.0,
              backgroundColor:
                  palette?.darkMutedColor?.color.withOpacity(0.4) ??
                      Colors.black38,
              foregroundColor: palette?.lightVibrantColor?.color,
              child: bookmarkViewModel.isBookmarked
                  ? const Icon(Icons.bookmark)
                  : const Icon(Icons.bookmark_border),
            ),
          ),
      ],
    );
  }
}
