import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/palette_function.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/model/castcredit_model.dart';

import 'package:palette_generator/palette_generator.dart';

class CastCreditCardWidget extends StatefulWidget {
  final int index;
  final int expandedIndex;
  final Cast castCredit;
  final ImageProvider image;
  final PaletteGenerator? palette;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const CastCreditCardWidget({
    Key? key,
    required this.index,
    required this.expandedIndex,
    required this.castCredit,
    required this.image,
    this.palette,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  State<CastCreditCardWidget> createState() => _CastCreditCardWidgetState();
}

class _CastCreditCardWidgetState extends State<CastCreditCardWidget> {
  bool isBack = false;

  @override
  void didUpdateWidget(covariant CastCreditCardWidget oldWidget) {
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
        onLongPress: () {
          widget.onLongPress?.call();
        },
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
                              Text(
                                widget.castCredit.overview ?? 'UNKNOWN',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: palette?.primaryColor?.bodyTextColor ??
                                      Colors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: palette?.darkMutedColor?.color ??
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Character',
                                      textAlign: TextAlign.center,
                                      style: TextStyles.robotoRegular10Style
                                          .copyWith(color: Colors.red
                                              // color: palette
                                              //     ?.darkMutedColor?.bodyTextColor,
                                              ),
                                    ),
                                    if (widget.castCredit.character != null ||
                                        widget.castCredit.character != '')
                                      Text(
                                        widget.castCredit.character.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyles.robotoMedium16Style
                                            .copyWith(
                                          color: palette
                                              ?.darkMutedColor?.bodyTextColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (widget.castCredit.date != null)
                                Text(
                                  'Release Year: ${widget.castCredit.date?.year}',
                                  style:
                                      TextStyles.robotoRegular10Style.copyWith(
                                    color:
                                        palette?.primaryColor?.bodyTextColor ??
                                            Colors.white,
                                  ),
                                ),
                              Text(
                                'If you want to go to the media detail page, please long press.',
                                style: TextStyles.robotoRegular10Style
                                    .copyWith(color: Colors.black38),
                                textAlign: TextAlign.center,
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
