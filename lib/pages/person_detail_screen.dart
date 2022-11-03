import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/palette_function.dart';
import 'package:flutter_application_1/model/base_model.dart';
import 'package:flutter_application_1/model/people_model.dart';
import 'package:flutter_application_1/pages/common/app_bar_widget.dart';
import 'package:flutter_application_1/pages/common/overview_widget.dart';
import 'package:flutter_application_1/pages/person/castcredit_widget.dart';
import 'package:flutter_application_1/pages/person/person_media_widget.dart';
import 'package:flutter_application_1/pages/person/person_showcase_widget.dart';

import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';

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

    ImageProvider image = CachedNetworkImageProvider(url);

    return FutureBuilder(
      future: image.toPalette(
        size: const Size(80, 128),
      ),
      builder: (context, AsyncSnapshot<PaletteGenerator?> snapshot) {
        if (snapshot.hasData) {
          palette = snapshot.data!;
        }

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
                    PersonShowcaseWidget(
                      person: person,
                      image: image,
                      palette: palette,
                    ),
                    OverviewWidget(
                      person,
                      palette: palette,
                    ),
                    PersonMediaWidget(widget.personID),
                    CardCreditWidget(
                      person,
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
}
