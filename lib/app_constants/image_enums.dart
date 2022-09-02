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
  google,
  twitter,
  profilepicture
}

enum ImageEnums {
  sampleimage,
  sampleimage2,
  samplebodyimage,
  samplecast,
  profilepicture
}

extension IconEnumsExtension on IconEnums {
  String get toPath => 'assets/icons/ic_$name.svg';

  SvgPicture get toImage => SvgPicture.asset(toPath);

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
        fit: BoxFit.cover,
      );

  String get toName {
    return name.capitalize();
  }
}