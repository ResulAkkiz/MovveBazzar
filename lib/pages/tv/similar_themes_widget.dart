import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/base_page.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:flutter_application_1/model/tv_trending_model.dart';
import 'package:flutter_application_1/pages/common/media_clip_widget.dart';
import 'package:flutter_application_1/pages/media_detail_screen.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:provider/provider.dart';

class SimilarThemesWidget extends StatefulWidget {
  final Tv tv;

  const SimilarThemesWidget(this.tv, {Key? key}) : super(key: key);

  @override
  State<SimilarThemesWidget> createState() => _SimilarThemesWidgetState();
}

class _SimilarThemesWidgetState extends BaseState<SimilarThemesWidget> {
  late final Tv tv = widget.tv;

  final double aspectRatio = 10 / 16;

  @override
  void initState() {
    super.initState();

    reload();
  }

  @override
  void didPopNext() {
    super.didPopNext();

    reload();
  }

  void reload() {
    context
        .read<MediaViewModel>()
        .getSimilarTvbyTvIDs(tv.id)
        .then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final MediaViewModel mediaViewModel = context.read<MediaViewModel>();
    final List<TvTrending> similiarTvList = mediaViewModel.similiarTvList;

    return similiarTvList.isEmpty
        ? const SizedBox.shrink()
        : Column(
            children: [
              buildTitle('Similar Themes'),
              SizedBox(
                height: (MediaQuery.of(context).size.shortestSide *
                        0.36 /
                        aspectRatio) +
                    64.0,
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowIndicator();
                    return false;
                  },
                  child: ListView.separated(
                    itemCount: similiarTvList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      var currentMedia = similiarTvList[index];
                      return InkWell(
                        child: MediaClipWidget(
                          currentMedia,
                          aspectRatio: aspectRatio,
                        ),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MediaDetailPage(
                              currentMedia.id!,
                              mediaType: 'tv',
                            ),
                          ),
                        ),
                      );
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
              ),
            ],
          );
  }
}
