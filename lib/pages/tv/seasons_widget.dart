import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:flutter_application_1/pages/tv/seasons_list_view.dart';
import 'package:palette_generator/palette_generator.dart';

class SeasonsWidget extends StatelessWidget {
  final Tv tv;
  final PaletteGenerator? palette;

  const SeasonsWidget(
    this.tv, {
    Key? key,
    this.palette,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Season>? seasons = tv.seasons;

    return seasons?.isEmpty ?? true
        ? const SizedBox.shrink()
        : Column(
            children: [
              buildTitle('Seasons'),
              SizedBox(
                height: 250,
                child: SeasonsListView(
                  seasons: seasons,
                  palette: palette,
                ),
              ),
            ],
          );
  }
}
