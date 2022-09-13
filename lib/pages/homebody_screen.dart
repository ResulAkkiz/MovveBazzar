import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/model/media.dart';
import 'package:intl/intl.dart';

class HomepageBody extends StatelessWidget {
  HomepageBody({Key? key}) : super(key: key);
  final List<Media> _mediaList = [
    Media(name: 'Shrek', date: DateTime.utc(2022, 07, 10)),
    Media(name: 'Avengers', date: DateTime.utc(2022, 5, 12)),
    Media(name: 'Mavi', date: DateTime.utc(2018, 07, 10)),
    Media(name: 'Shrek', date: DateTime.utc(2022, 07, 10)),
    Media(name: 'Shrek', date: DateTime.utc(2022, 07, 10))
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        15.0,
        15.0,
        15.0,
        MediaQuery.of(context).size.width * 0.3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Movie',
            style: TextStyles.robotoHeadlineStyle,
          ),
          _buildSampleListView(context),
          Text(
            'TV Show',
            style: TextStyles.robotoHeadlineStyle,
          ),
          _buildSampleListView(context),
          Text(
            'Trends',
            style: TextStyles.robotoHeadlineStyle,
          ),
          _buildSampleListView(context),
          Text(
            'Trends',
            style: TextStyles.robotoHeadlineStyle,
          ),
          _buildSampleListView(context),
        ],
      ),
    );
  }

  Padding _buildSampleListView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.60,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: ListView.builder(
              itemCount: _mediaList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                Media currentMedia = _mediaList[index];
                return buildFilmCard(
                    dateFilm: currentMedia.date, filmName: currentMedia.name);
              }),
        ),
      ),
    );
  }

  Column buildFilmCard({required String filmName, required DateTime dateFilm}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 143, // Svg image place here
            height: 186,
            child: ImageEnums.sampleimage.toImage),
        Text(
          filmName,
          style: TextStyles.robotoMediumStyle,
        ),
        Text(
          DateFormat.yMMMd().format(dateFilm),
          style: TextStyles.robotoRegularStyle,
        ),
      ],
    );
  }
}

// child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: [
//               buildFilmCard(filmName: 'Wonder', dateFilm: DateTime.now()),
//               buildFilmCard(filmName: 'Avengers', dateFilm: DateTime.now()),
//               buildFilmCard(filmName: 'Shrek 2', dateFilm: DateTime.now()),
//               buildFilmCard(filmName: 'Avengers', dateFilm: DateTime.now()),
//               buildFilmCard(filmName: 'Avengers', dateFilm: DateTime.now()),
//               buildFilmCard(filmName: 'Avengers', dateFilm: DateTime.now()),
//               buildFilmCard(filmName: 'Avengers', dateFilm: DateTime.now()),
//               buildFilmCard(filmName: 'Avengers', dateFilm: DateTime.now()),
//               buildFilmCard(filmName: 'Avengers', dateFilm: DateTime.now()),
//               buildFilmCard(filmName: 'Avengers', dateFilm: DateTime.now()),
//             ],
//           ),
