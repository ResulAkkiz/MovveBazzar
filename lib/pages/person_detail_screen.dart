import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/palette_function.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/model/base_model.dart';
import 'package:flutter_application_1/model/people_model.dart';
import 'package:flutter_application_1/pages/common/app_bar_widget.dart';
import 'package:flutter_application_1/pages/common/overview_widget.dart';
import 'package:flutter_application_1/pages/person/castcredit_widget.dart';
import 'package:flutter_application_1/pages/person/person_media_widget.dart';

import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import 'common/loader_widget.dart';

class PersonDetailScreen extends StatefulWidget {
  final int personID;
  const PersonDetailScreen({super.key, required this.personID});

  @override
  State<PersonDetailScreen> createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailScreen> {
  PaletteGenerator? palette;
  @override
  void initState() {
    debugPrint('${widget.personID} Initstate tetikelendi');
    context
        .read<MediaViewModel>()
        .getMediasbyMediaID(widget.personID, 'person');
    context.read<MediaViewModel>().getCastCreditbyPersonID(widget.personID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaViewModel mediaViewModel = context.read<MediaViewModel>();

    return FutureBuilder<IBaseModel>(
      future: mediaViewModel.getDetailbyID(widget.personID, 'person'),
      builder: (context, AsyncSnapshot<IBaseModel> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          Person person = snapshot.data! as Person;

          return loadContent(person);
        }

        return const SplashScreen();
      },
    );
  }

  FutureBuilder<PaletteGenerator?> loadContent(Person person) {
    String url = getImage(
      path: person.posterPath,
      size: 'w300',
    );
    final MediaViewModel mediaViewModel = Provider.of<MediaViewModel>(context);

    ImageProvider image = CachedNetworkImageProvider(url);
    const double posterAspectRatio = 5 / 8;
    return FutureBuilder(
      future: image.toPalette(
        size: const Size(80, 128),
      ),
      builder: (context, AsyncSnapshot<PaletteGenerator?> snapshot) {
        if (snapshot.hasData) {
          palette = snapshot.data!;
        }

        Color? scaffoldBackgroundColor = palette?.darkMutedColor?.color ??
            Theme.of(context).scaffoldBackgroundColor;

        return Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBarWidget(
                person,
                palette: palette,
              ),
              backgroundColor: palette?.darkMutedColor?.color,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    AspectRatio(
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
                                  scaffoldBackgroundColor
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  person.name ?? 'UNKNOWN',
                                  style: TextStyles.robotoBoldStyle.copyWith(
                                    color: palette?.lightVibrantColor?.color,
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Wrap(
                                  runSpacing: 15,
                                  spacing: 15,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    if (person.birthday != null)
                                      buildPersonProp(
                                        text: DateFormat.yMMMd()
                                            .format(person.birthday!),
                                        widget: const Icon(Icons.cake),
                                        backgroundColor:
                                            const Color(0xFF138086),
                                      ),
                                    buildPersonProp(
                                      text: person.deathday != null
                                          ? DateFormat.yMMMd()
                                              .format(person.deathday!)
                                          : '—',
                                      widget:
                                          const Icon(FontAwesomeIcons.skull),
                                      backgroundColor: const Color(0xFF534666),
                                    ),
                                    if (person.knownForDepartment != null)
                                      buildPersonProp(
                                        text: person.knownForDepartment,
                                        widget: const Icon(
                                            FontAwesomeIcons.angellist),
                                        backgroundColor:
                                            const Color(0xFF974063),
                                      ),
                                    if (person.gender != null)
                                      buildPersonProp(
                                        text: person.gender == 2
                                            ? 'Male'
                                            : 'Female',
                                        widget: person.gender == 2
                                            ? const Icon(
                                                FontAwesomeIcons.person)
                                            : const Icon(
                                                FontAwesomeIcons.personDress),
                                        backgroundColor: person.gender == 2
                                            ? const Color(0xFF75E2FF)
                                            : const Color(0xFFF54768),
                                      ),
                                    if (person.placeOfBirth != null)
                                      buildPersonProp(
                                        text: person.placeOfBirth,
                                        widget: const Icon(
                                            FontAwesomeIcons.earthAmericas),
                                        backgroundColor:
                                            const Color(0xFF6E44FF),
                                      ),
                                  ],
                                ),
                              ],
                            ).separated(const SizedBox(
                              height: 15,
                            )),
                          )
                        ],
                      ),
                    ),
                    OverviewWidget(person),
                    PersonMediaWidget(widget.personID),
                    CardCreditWidget(
                      mediaViewModel.castCreditList,
                      palette: palette,
                    )
                  ],
                ),
              ),
            ),
            if (snapshot.connectionState == ConnectionState.waiting)
              const LoaderWidget(),
          ],
        );
      },
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

  Widget buildBackDropImage(Person media, ImageProvider placeholder) {
    String url = getImage(
      path: media.posterPath,
      size: 'original',
    );
    final ImageProvider image = CachedNetworkImageProvider(url);
    Color dominantColor = palette?.primaryColor?.color ?? Colors.transparent;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 32.0,
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
