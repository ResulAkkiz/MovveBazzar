import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/model/base_model.dart';
import 'package:palette_generator/palette_generator.dart';

class OverviewWidget extends StatelessWidget {
  final IBaseModel media;
  final PaletteGenerator? palette;

  const OverviewWidget(
    this.media, {
    Key? key,
    this.palette,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return media.overview?.isEmpty ?? true
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              media.overview!,
              style: TextStyles.robotoRegular19Style.copyWith(
                color: palette?.darkMutedColor?.bodyTextColor ??
                    Colors.white.withOpacity(0.5),
              ),
            ),
          );
  }
}
