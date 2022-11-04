import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum IconEnums {
  bookmark,
  home,
  play,
  profile,
  search,
  backarrow,
  emptystar,
  fullstar,
  halfstar,
  google,
  twitter,
  profilepicture,
  danger,
  shake,
  applogo,
  appicon,
}

enum ImageEnums {
  applogo,
  appicon,
  sampleimage,
  sampleimage2,
  samplebodyimage,
  samplecast,
  profilepicture,
  celebrity,
  glasses,
}

extension IconEnumsExtension on IconEnums {
  String get toPath => 'assets/icons/ic_$name.svg';

  SvgPicture get toImage => SvgPicture.asset(toPath);

  SvgPicture toIcon({
    Color? color,
    double dimension = 24.0,
  }) =>
      SvgPicture.asset(
        toPath,
        width: dimension,
        height: dimension,
        color: color ?? Colors.white,
      );

  String get toName {
    return name.capitalize();
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension ImageEnumsExtension on ImageEnums {
  String get toPath => 'assets/images/im_$name.png';

  Image get toImage => Image.asset(toPath);

  Image get toImagewithBoxFit => Image.asset(
        toPath,
        fit: BoxFit.fill,
      );

  String get toName {
    return name.capitalize();
  }
}
