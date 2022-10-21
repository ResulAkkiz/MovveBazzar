import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:flutter_application_1/pages/tv/season_card_widget.dart';
import 'package:palette_generator/palette_generator.dart';

class SeasonsListView extends StatefulWidget {
  final List<PaletteGenerator?> palette;
  final List<ImageProvider> images;
  final List<Season>? seasons;

  const SeasonsListView({
    Key? key,
    required this.palette,
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
    List<PaletteGenerator?> palette = widget.palette;

    List<Color?> dominantColors = List.filled(widget.images.length, null);
    List<Color?> bodyTextColors = List.filled(widget.images.length, null);

    if (palette.isNotEmpty) {
      dominantColors = List.generate(images.length,
          (index) => palette.elementAt(index)?.dominantColor?.color);
      bodyTextColors = List.generate(images.length,
          (index) => palette.elementAt(index)?.dominantColor?.bodyTextColor);
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: seasons?.length,
      itemBuilder: (context, index) {
        Season season = seasons![index];

        return SeasonCardWidget(
          index: index,
          expandedIndex: expandedIndex,
          season: season,
          image: images[index],
          dominantColor: dominantColors[index],
          bodyTextColor: bodyTextColors[index],
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
