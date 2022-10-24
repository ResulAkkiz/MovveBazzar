import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/palette_function.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/model/tv_model.dart';
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';

class SeasonCardWidget extends StatefulWidget {
  final int index;
  final int expandedIndex;
  final Season season;
  final ImageProvider image;
  final PaletteGenerator? palette;
  final VoidCallback? onTap;

  const SeasonCardWidget({
    Key? key,
    required this.index,
    required this.expandedIndex,
    required this.season,
    required this.image,
    this.palette,
    this.onTap,
  }) : super(key: key);

  @override
  State<SeasonCardWidget> createState() => _SeasonCardWidgetState();
}

class _SeasonCardWidgetState extends State<SeasonCardWidget> {
  bool isBack = false;

  @override
  void didUpdateWidget(covariant SeasonCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expandedIndex != widget.expandedIndex) {
      isBack = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    PaletteGenerator? palette = widget.palette;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          isBack = !isBack;
          widget.onTap?.call();
        },
        child: TweenAnimationBuilder(
          tween: Tween<double>(
            begin: 0,
            end: isBack ? pi : 0,
          ),
          duration: const Duration(seconds: 1),
          builder: (BuildContext context, double val, _) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(val),
              child: val >= (pi / 2)
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(val),
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          color: palette?.primaryColor?.color ??
                              Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          child: Column(
                            children: [
                              Chip(
                                backgroundColor: palette
                                        ?.darkMutedColor?.color ??
                                    Theme.of(context).scaffoldBackgroundColor,
                                label: Text(
                                  widget.season.name.toString(),
                                  style:
                                      TextStyles.robotoMedium16Style.copyWith(
                                    color:
                                        palette?.darkMutedColor?.bodyTextColor,
                                  ),
                                ),
                              ),
                              Text(
                                widget.season.overview ?? 'UNKNOWN',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: palette?.primaryColor?.bodyTextColor ??
                                      Colors.white,
                                ),
                              ),
                              Text(
                                'Episode Count:${widget.season.episodeCount}',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: palette?.primaryColor?.bodyTextColor ??
                                      Colors.white,
                                ),
                              ),
                              Text(
                                'First Air Date: ${DateFormat('dd-MM-yyyy').format(widget.season.airDate ?? DateTime.now())}',
                                style: TextStyles.robotoRegular10Style.copyWith(
                                  color: palette?.primaryColor?.bodyTextColor ??
                                      Colors.white,
                                ),
                              ),
                            ],
                          ).separated(const SizedBox(
                            height: 6,
                          )),
                        ),
                      ),
                    )
                  : AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: widget.expandedIndex == widget.index ? 150 : 35,
                      decoration: BoxDecoration(
                        color: palette?.primaryColor?.color ??
                            Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image(
                        fit: BoxFit.cover,
                        image: widget.image,
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
