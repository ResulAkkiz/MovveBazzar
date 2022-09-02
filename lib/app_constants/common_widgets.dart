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

// Widget buildDateTimePicker({
//   required IconData iconData,
//     required String hintText,
//   required BuildContext context,
//   DateTime? date,
// }) {
//   return Stack(
//     alignment: Alignment.centerLeft,
//     children: [
//       GestureDetector(onTap: () {

//       },
//         child: TextFormField(
//           cursorColor: Colors.red,
//           decoration: InputDecoration(
//               hintText: hintText,
//               contentPadding: const EdgeInsets.fromLTRB(74, 12, 10, 12)),
//         ),
//       ),
//       CircleAvatar(
//         radius: 32,
//         child: Icon(
//           iconData,
//           size: 48,
//         ),
//       ),
//     ],
//   );
// }

Future<DateTime?> pickDate(BuildContext context) async => showDatePicker(
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1910),
    lastDate: DateTime.now());

Widget buildDateTimePicker(
    {required IconData iconData,
    required BuildContext context,
    required Function(DateTime) onSelected,
    required TextEditingController controller}) {
  return InkWell(
    onTap: () async {
      final date = await pickDate(context);
      if (date == null) return;
      controller.text = '${date.day}/${date.month}/${date.year}';

      onSelected(date); //16/08/1998
    },
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        TextFormField(
          readOnly: true,
          controller: controller,
          decoration: InputDecoration(
              hintText: controller.text == ''
                  ? 'Select your Birthday'
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