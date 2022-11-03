import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/model/people_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';

class PersonPropertiesWidget extends StatefulWidget {
  final Person person;
  final PaletteGenerator? palette;
  const PersonPropertiesWidget({super.key, required this.person, this.palette});

  @override
  State<PersonPropertiesWidget> createState() => _PersonPropertiesWidgetState();
}

class _PersonPropertiesWidgetState extends State<PersonPropertiesWidget> {
  @override
  Widget build(BuildContext context) {
    Person person = widget.person;
    PaletteGenerator? palette = widget.palette;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            person.name ?? 'UNKNOWN',
            style: TextStyles.robotoBoldStyle.copyWith(
              color: palette?.lightVibrantColor?.color,
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Wrap(
          runSpacing: 15,
          spacing: 15,
          alignment: WrapAlignment.center,
          children: [
            if (person.birthday != null)
              buildPersonProp(
                text: DateFormat.yMMMd().format(person.birthday!),
                widget: const Icon(Icons.cake),
                backgroundColor: const Color(0xFF138086),
              ),
            buildPersonProp(
              text: person.deathday != null
                  ? DateFormat.yMMMd().format(person.deathday!)
                  : '—',
              widget: const Icon(FontAwesomeIcons.skull),
              backgroundColor: const Color(0xFF534666),
            ),
            if (person.knownForDepartment != null)
              buildPersonProp(
                text: person.knownForDepartment,
                widget: const Icon(FontAwesomeIcons.angellist),
                backgroundColor: const Color(0xFF974063),
              ),
            if (person.gender != null)
              buildPersonProp(
                text: person.gender == 2 ? 'Male' : 'Female',
                widget: person.gender == 2
                    ? const Icon(FontAwesomeIcons.person)
                    : const Icon(FontAwesomeIcons.personDress),
                backgroundColor: person.gender == 2
                    ? const Color(0xFF75E2FF)
                    : const Color(0xFFF54768),
              ),
            if (person.placeOfBirth != null)
              buildPersonProp(
                text: person.placeOfBirth,
                widget: const Icon(FontAwesomeIcons.earthAmericas),
                backgroundColor: const Color(0xFF6E44FF),
              ),
          ],
        ),
      ],
    );
  }

  Column buildPersonProp(
      {String? text, required Widget widget, required Color backgroundColor}) {
    return Column(
      children: [
        CircleAvatar(
          foregroundColor: Colors.white,
          radius: 20,
          backgroundColor: backgroundColor,
          child: Center(child: widget),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          children: [
            if (text != null)
              Text(
                text,
                style: TextStyles.robotoRegular12Style,
              ),
          ],
        ),
      ],
    );
  }
}
