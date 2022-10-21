import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:shake/shake.dart';

class ShakeScreen extends StatefulWidget {
  const ShakeScreen({super.key});

  @override
  State<ShakeScreen> createState() => _ShakeScreenState();
}

class _ShakeScreenState extends State<ShakeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
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
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 36.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });
    return Center(
      child: AnimatedBuilder(
        builder: (context, widget) {
          debugPrint('Value :${offsetAnimation.value}');
          return Container(
            margin: EdgeInsets.only(
                left: offsetAnimation.value + 36.0,
                right: 36.0 - offsetAnimation.value),
            height: MediaQuery.of(context).size.longestSide * 0.6,
            width: MediaQuery.of(context).size.shortestSide * 0.7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.question_mark_outlined,
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
          );
        },
        animation: offsetAnimation,
      ),
    );
  }
}
