import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/palette_function.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:flutter_application_1/pages/tv/season_card_widget.dart';
import 'package:palette_generator/palette_generator.dart';

class SeasonsListView extends StatefulWidget {
  final List<ImageProvider> images;
  final Palettes? palettes;
  final List<Season>? seasons;

  const SeasonsListView({
    Key? key,
    required this.images,
    this.palettes,
    this.seasons,
  }) : super(key: key);

  @override
  State<SeasonsListView> createState() => _SeasonsListViewState();
}

class _SeasonsListViewState extends State<SeasonsListView> {
  int expandedIndex = 0;

  late List<ImageProvider> images = widget.images;
  late List<Season>? seasons = widget.seasons;

  @override
  Widget build(BuildContext context) {
    Palettes palettes = widget.palettes ?? Palettes.empty();

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: seasons?.length,
      itemBuilder: (context, index) {
        Season season = seasons![index];
        ImageProvider image = images[index];
        PaletteGenerator? palette = palettes.isEmpty ? null : palettes[index];

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
