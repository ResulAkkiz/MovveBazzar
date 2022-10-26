import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/services/firebase_auth_service.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

RichText buildLogo() {
  return RichText(
    text: TextSpan(
      text: 'Mov',
      style: TextStyles.splashLogoStyle,
      children: const [
        TextSpan(
          text: 've',
          style: TextStyle(
            color: Color(0xFFE11A38),
          ),
        ),
      ],
    ),
  );
}

Container buildSigninContainer(
    {required SvgPicture svgPicture, required void Function() onPressed}) {
  return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: IconButton(onPressed: onPressed, icon: svgPicture));
}

RichText buildAppBarLogo() {
  return RichText(
    text: TextSpan(
      text: 'Mov',
      style: TextStyles.appBarTitleStyle,
      children: const [
        TextSpan(
          text: 've',
          style: TextStyle(
            color: Color(0xFFE11A38),
          ),
        ),
      ],
    ),
  );
}

Widget buildMoreTrendsDDB(
    {String? value,
    required void Function(String?)? onChanged,
    required List<DropdownMenuItem<String>>? items}) {
  return DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.transparent,
      border: Border.all(color: Colors.red, width: 1),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: DropdownButton<String>(
          style: TextStyles.robotoMedium18Style,
          value: value,
          underline: const SizedBox(),
          items: items,
          onChanged: onChanged),
    ),
  );
}

Widget buildLoginTextformField({
  required IconData iconData,
  required String hintText,
  required TextEditingController textEditingController,
  bool readOnly = false,
  TextInputType? keyboardType,
}) {
  return Stack(
    alignment: Alignment.centerLeft,
    children: [
      TextFormField(
        readOnly: readOnly,
        controller: textEditingController,
        keyboardType: keyboardType,
        cursorColor: Colors.red,
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

Widget buildSignupTextformField(
    {required BuildContext context,
    required IconData iconData,
    required String hintText,
    required TextEditingController controller,
    required bool isPassword,
    String? Function(String?)? validator}) {
  return FormField(
      validator: validator,
      builder: (state) {
        return Column(
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                TextFormField(
                  onChanged: (value) {
                    state.didChange(value);
                  },
                  controller: controller,
                  obscureText: isPassword,
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                      hintText: hintText,
                      contentPadding:
                          const EdgeInsets.fromLTRB(74, 12, 10, 12)),
                ),
                CircleAvatar(
                  radius: 32,
                  child: Icon(
                    iconData,
                    size: 48,
                  ),
                ),
              ],
            ),
            if (state.hasError)
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 74.0),
                      child: Text(
                        state.errorText ?? '',
                        style:
                            Theme.of(context).inputDecorationTheme.errorStyle,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        );
      });
}

Future<DateTime?> pickDate(BuildContext context) async => showDatePicker(
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1910),
    lastDate: DateTime.now());

Future<dynamic> buildShowModelBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      backgroundColor: Theme.of(context).primaryColor,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.square(
                dimension: MediaQuery.of(context).size.width * 0.3,
                child: IconEnums.danger.toImage,
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(errorMessage,
                      overflow: TextOverflow.clip,
                      style: TextStyles.robotoRegularBold24Style
                          .copyWith(color: Colors.black)),
                ),
              ),
            ],
          ),
        );
      });
}

Widget buildGenreList(BuildContext context) {
  Set<String> genres = context.read<MediaViewModel>().genreNameList;
  return SizedBox(
    height: MediaQuery.of(context).size.shortestSide * 0.10,
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: genres.length,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Text(
            genres.elementAt(index),
            style: TextStyles.robotoMedium12Style,
          ),
        );
      },
    ),
  );
}

Row buildRatingBar({required num voteAverage, required num voteCount}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        voteAverage.toStringAsFixed(1),
        style: TextStyles.robotoMedium18Style
            .copyWith(color: const Color(0xFFFDC432)),
      ),
      RatingBar(
        ignoreGestures: true,
        itemSize: 20,
        initialRating: voteAverage / 2,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        onRatingUpdate: (rating) {},
        ratingWidget: RatingWidget(
          full: IconEnums.fullstar.toImage,
          half: IconEnums.halfstar.toImage,
          empty: IconEnums.emptystar.toImage,
        ),
      ),
      Text(
        '(${voteCount.toStringAsFixed(1)})',
        style: TextStyles.robotoRegular10Style.copyWith(
          color: Colors.white.withOpacity(0.4),
        ),
      ),
    ],
  );
}

Widget buildDateTimePicker(
    {required IconData iconData,
    required BuildContext context,
    required void Function(DateTime) onSelected,
    required TextEditingController controller}) {
  return InkWell(
    onTap: () async {
      final date = await pickDate(context);
      if (date == null) return;
      controller.text = '${date.day}/${date.month}/${date.year}';
      onSelected(date);
    },
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        TextFormField(
          readOnly: true,
          controller: controller,
          decoration: InputDecoration(
              hintText: controller.text == ''
                  ? 'Select your birthday'
                  : controller.text,
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
    ),
  );
}

Widget buildTitle(String title) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 10,
    ),
    alignment: Alignment.centerLeft,
    child: Text(
      title,
      style: TextStyles.robotoMedium30Style,
    ),
  );
}
