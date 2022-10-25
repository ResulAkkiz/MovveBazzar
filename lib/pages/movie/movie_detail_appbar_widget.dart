import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/bookmark_model.dart';
import 'package:flutter_application_1/model/movie_model.dart';
import 'package:flutter_application_1/viewmodel/bookmark_view_model.dart';
import 'package:flutter_application_1/viewmodel/movier_view_model.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class MovieDetailAppBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  final Movie movie;
  final PaletteGenerator? palette;

  @override
  final Size preferredSize;

  const MovieDetailAppBarWidget(
    this.movie, {
    Key? key,
    this.palette,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  State<MovieDetailAppBarWidget> createState() =>
      _MovieDetailAppBarWidgetState();
}

class _MovieDetailAppBarWidgetState extends State<MovieDetailAppBarWidget> {
  late final Movie movie = widget.movie;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookmarkViewModel>().searchingBookmark(movie.id);
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
        IconButton(
          onPressed: () {
            bookmarkViewModel.isBookmarked
                ? bookmarkViewModel.deleteBookmark(
                    movierViewModel.movier!.movierID, movie.id)
                : bookmarkViewModel.saveBookMarks(
                    movierViewModel.movier!.movierID,
                    BookMark(
                      runtime: movie.runtime,
                      date: movie.releaseDate,
                      mediaType: 'movie',
                      mediaID: movie.id,
                      mediaVote: movie.voteAverage,
                      mediaName: movie.title ?? '',
                      imagePath: movie.posterPath,
                    ),
                  );
          },
          icon: CircleAvatar(
            radius: 16.0,
            backgroundColor: palette?.darkMutedColor?.color.withOpacity(0.4) ??
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
