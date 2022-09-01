import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

RichText buildLogo() {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: 'Mov',
          style: TextStyles.splashLogoStyle,
        ),
        TextSpan(
          text: 've',
          style: TextStyles.splashLogoStyle.copyWith(
            color: const Color(0xFFE11A38),
          ),
        ),
      ],
    ),
  );
}

Container buildSigninContainer({required SvgPicture svgPicture}) {
  return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: IconButton(onPressed: () {}, icon: svgPicture));
}

Widget buildLoginTextformField({
  required IconData iconData,
  required String hintText,
}) {
  return Stack(
    alignment: Alignment.centerLeft,
    children: [
      TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.fromLTRB(74, 12, 10, 12)),
      ),
      CircleAvatar(
        radius: 32,
        child: Icon(
          iconData,
          size: 48,
        ),
      ),
    ],
  );
}
