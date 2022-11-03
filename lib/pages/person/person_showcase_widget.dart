import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/app_constants/palette_function.dart';

import 'package:flutter_application_1/model/people_model.dart';
import 'package:flutter_application_1/pages/person/person_properties_widget.dart';
import 'package:palette_generator/palette_generator.dart';

class PersonShowcaseWidget extends StatelessWidget {
  final PaletteGenerator? palette;
  final Person person;
  final ImageProvider image;
  const PersonShowcaseWidget(
      {super.key, this.palette, required this.person, required this.image});

  @override
  Widget build(BuildContext context) {
    const double posterAspectRatio = 5 / 8;
    Color? scaffoldBackgroundColor = palette?.darkMutedColor?.color ??
        Theme.of(context).scaffoldBackgroundColor;
    return AspectRatio(
      aspectRatio: posterAspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          buildBackDropImage(person, image),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.6, 0.82],
                colors: [
                  scaffoldBackgroundColor.withOpacity(0),
                  scaffoldBackgroundColor,
                ],
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: PersonPropertiesWidget(
              person: person,
              palette: palette,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBackDropImage(Person person, ImageProvider placeholder) {
    String url = getImage(
      path: person.posterPath,
      size: 'original',
    );
    final ImageProvider image = CachedNetworkImageProvider(url);
    Color dominantColor = palette?.primaryColor?.color ?? Colors.transparent;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: dominantColor,
              image: DecorationImage(
                image: placeholder,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Image(
            image: image,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
