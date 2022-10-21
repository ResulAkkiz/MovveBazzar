import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/palette_function.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:flutter_application_1/pages/tv/season_card_widget.dart';
import 'package:palette_generator/palette_generator.dart';

class SeasonsListView extends StatefulWidget {
  final Palettes palettes;
  final List<ImageProvider> images;
  final List<Season>? seasons;

  const SeasonsListView({
    Key? key,
    required this.palettes,
    required this.images,
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
    Palettes palettes = widget.palettes;

    List<PaletteColor?> dominantColors =
        List.filled(widget.images.length, null);

    if (palettes.isNotEmpty) {
      dominantColors = List.generate(
          images.length, (index) => palettes.elementAt(index)?.dominantColor);
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: seasons?.length,
      itemBuilder: (context, index) {
        Season season = seasons![index];
        ImageProvider image = images[index];
        PaletteColor? dominantColor = dominantColors[index];

        return SeasonCardWidget(
          index: index,
          expandedIndex: expandedIndex,
          season: season,
          image: image,
          dominantColor: dominantColor,
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
