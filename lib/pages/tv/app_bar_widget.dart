import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/bookmark_model.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:flutter_application_1/viewmodel/bookmark_view_model.dart';
import 'package:flutter_application_1/viewmodel/movier_view_model.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final Tv tv;
  final PaletteGenerator? palette;

  @override
  final Size preferredSize;

  const AppBarWidget(
    this.tv, {
    Key? key,
    this.palette,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  late final Tv tv = widget.tv;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookmarkViewModel>().searchingBookmark(tv.id!);
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
            debugPrint(
                '////////////////////${bookmarkViewModel.isBookmarked}/////////////////////');
            bookmarkViewModel.isBookmarked
                ? bookmarkViewModel.deleteBookmark(
                    movierViewModel.movier!.movierID, tv.id!)
                : bookmarkViewModel.saveBookMarks(
                    movierViewModel.movier!.movierID,
                    BookMark(
                      runtime: tv.episodeRunTime!.first,
                      date: tv.firstAirDate,
                      mediaType: 'tv',
                      mediaID: tv.id ?? 1,
                      mediaVote: tv.voteAverage,
                      mediaName: tv.name ?? '',
                      imagePath: tv.posterPath ?? '',
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
