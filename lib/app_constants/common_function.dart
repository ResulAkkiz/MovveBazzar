import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:cool_alert/src/constants/images.dart';
import 'package:cool_alert/src/utils/animate.dart';
import 'package:cool_alert/src/utils/single_loop_controller.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

String generateRandomString(int len) {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}

String getImage({required String? path, required String size}) {
  return path != null
      ? 'https://image.tmdb.org/t/p/$size$path'
      : 'https://img.freepik.com/free-vector/isometric-cinema-icon-set_1284-18691.jpg?w=1060&t=st=1667910914~exp=1667911514~hmac=81739c05e0e8e63931c93a0136696a7f338e9b2548b59a990d6922a35c81cc2d';
}

String getImageWithType({
  required String? path,
  required String size,
  required String type,
}) {
  if (path != null) {
    return 'https://image.tmdb.org/t/p/$size$path';
  } else {
    if (type == 'person') {
      return 'https://inspgr.id/app/uploads/2020/05/illustration-ricardo-polo-02.jpg';
    } else {
      return 'https://img.freepik.com/free-vector/isometric-cinema-icon-set_1284-18691.jpg?w=1060&t=st=1667910914~exp=1667911514~hmac=81739c05e0e8e63931c93a0136696a7f338e9b2548b59a990d6922a35c81cc2d';
    }
  }
}

void showCoolerDialog(
  BuildContext context, {
  int? seconds = 2,
  CoolAlertType types = CoolAlertType.success,
}) {
  Widget buildHeader(context) {
    CoolAlertType type = types;

    String? anim = AppAnim.success;

    switch (type) {
      case CoolAlertType.success:
        anim = AppAnim.success;
        break;
      case CoolAlertType.error:
        anim = AppAnim.error;
        break;
      case CoolAlertType.warning:
        anim = AppAnim.warning;
        break;
      case CoolAlertType.confirm:
        anim = AppAnim.info;
        break;
      case CoolAlertType.info:
        anim = AppAnim.info;
        break;
      case CoolAlertType.loading:
        anim = AppAnim.loading;
        break;
      default:
        anim = AppAnim.info;
    }

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: SizedBox(
        height: 200,
        width: 200,
        child: FlareActor(
          anim,
          animation: type == CoolAlertType.loading ? 'play' : null,
          controller: type == CoolAlertType.loading
              ? null
              : SingleLoopController(
                  'play',
                  1,
                ),
          //color: Colors.black, we'll use this line for loading situation.
        ),
      ),
    );
  }

  showGeneralDialog(
    transitionBuilder: (context, anim1, __, widget) {
      return Animate.scale(
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: widget,
        ),
        animation: anim1,
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
    barrierDismissible: false,
    barrierLabel: '',
    context: context,
    routeSettings: const RouteSettings(name: 'alertDialog'),
    pageBuilder: (context, _, __) {
      if (seconds != null) {
        Future.delayed(Duration(seconds: seconds), () {
          Navigator.of(context)
              .popUntil((route) => route.settings.name != 'alertDialog');
        });
      }
      return buildHeader(context);
    },
  );
}
