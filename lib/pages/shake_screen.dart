import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';

class ShakeScreen extends StatefulWidget {
  const ShakeScreen({super.key});

  @override
  State<ShakeScreen> createState() => _ShakeScreenState();
}

class _ShakeScreenState extends State<ShakeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isDone = false;
  late IBaseTrendingModel? randomTrendMedia;
  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        getRandomTrendMedia();
        controller.forward(from: 0.0);
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 200,
      shakeThresholdGravity: 2.7,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getRandomTrendMedia() async {
    if (mounted) {
      randomTrendMedia =
          await context.read<MediaViewModel>().getRandomTrendingMedia();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 4 * pi)
        .chain(CurveTween(curve: Curves.bounceIn))
        .animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isDone = true;
        }
      });
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 90),
        child: AnimatedBuilder(
          builder: (context, widget) {
            return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(offsetAnimation.value),
                child: isDone
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.6)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              //'https://image.tmdb.org/t/p/original/pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg',
                              CachedNetworkImage(
                                imageUrl: getImage(
                                    path: randomTrendMedia?.posterPath,
                                    size: 'original'),
                                imageBuilder: (context, imageProvider) =>
                                    AspectRatio(
                                  aspectRatio: 0.8,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) {
                                  return const SizedBox.square(
                                    dimension: 250,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
                              ),
                              Text(randomTrendMedia!.mediaName.toString(),
                                  style: TextStyles.robotoBoldStyle
                                      .copyWith(fontSize: 25),
                                  textAlign: TextAlign.center),
                              buildRatingBar(
                                  voteAverage:
                                      randomTrendMedia!.voteAverage ?? 0,
                                  voteCount: randomTrendMedia!.voteCount ?? 0),
                              buildGenreList(context,
                                  ['Science Fiction', 'Drama', 'Action']),
                              Text(
                                'Shake me again, if you are not pleasent from result.',
                                style: TextStyles.robotoMedium12Style.copyWith(
                                    fontSize: 10,
                                    color: Colors.white.withOpacity(0.4)),
                              ),
                            ],
                          ).separated(const SizedBox(
                            height: 5,
                          )),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.longestSide * 0.6,
                        width: MediaQuery.of(context).size.shortestSide * 0.7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.question_mark_outlined,
                              color: Theme.of(context).primaryColor,
                              size: 150,
                            ),
                            Text(
                              'Try your chance.',
                              style: TextStyles.robotoMedium16Style,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Shake me!!',
                              style: TextStyles.appBarTitleStyle,
                            ),
                          ],
                        ),
                      ));
          },
          animation: offsetAnimation,
        ),
      ),
    );
  }
}
