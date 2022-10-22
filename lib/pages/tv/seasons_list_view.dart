import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:flutter_application_1/pages/tv/season_card_widget.dart';
import 'package:palette_generator/palette_generator.dart';

class SeasonsListView extends StatefulWidget {
  final PaletteGenerator? palette;
  final List<Season>? seasons;

  const SeasonsListView({
    Key? key,
    this.palette,
    this.seasons,
  }) : super(key: key);

  @override
  State<SeasonsListView> createState() => _SeasonsListViewState();
}

class _SeasonsListViewState extends State<SeasonsListView> {
  int expandedIndex = 0;

  late List<Season>? seasons = widget.seasons;

  @override
  Widget build(BuildContext context) {
    PaletteGenerator? palette = widget.palette;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: seasons?.length,
      itemBuilder: (context, index) {
        Season season = seasons![index];

        String url = getImage(
          path: season.posterPath,
          size: 'original',
        );

        ImageProvider image = CachedNetworkImageProvider(url);

        return SeasonCardWidget(
          index: index,
          expandedIndex: expandedIndex,
          season: season,
          image: image,
          palette: palette,
          onTap: () {
            expandedIndex = index;
            if (mounted) {
              setState(() {});
            }
          },
        );
      },
    );
  }
}
