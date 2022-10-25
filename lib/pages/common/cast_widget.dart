import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/model/people_cast_model.dart';

import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:provider/provider.dart';

class CastWidget extends StatefulWidget {
  final int mediaID;
  final String mediaType;

  const CastWidget(this.mediaID, this.mediaType, {Key? key}) : super(key: key);

  @override
  State<CastWidget> createState() => _CastWidgetState();
}

class _CastWidgetState extends State<CastWidget> {
  @override
  void initState() {
    super.initState();

    context
        .read<MediaViewModel>()
        .getCastbyMediaIDs(widget.mediaID, widget.mediaType);
  }

  @override
  Widget build(BuildContext context) {
    final MediaViewModel mediaViewModel = context.read<MediaViewModel>();
    final List<PeopleCast> people = mediaViewModel.peopleCastList;

    return Column(
      children: [
        buildTitle('Cast'),
        Container(
          alignment: Alignment.centerLeft,
          height: MediaQuery.of(context).size.shortestSide / 3.3,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemExtent: 80,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: people.length,
            itemBuilder: (BuildContext context, int index) {
              PeopleCast person = people[index];

              return Column(
                children: [
                  ClipOval(
                    child: person.profilePath != null
                        ? CachedNetworkImage(
                            width: 60,
                            height: 60,
                            fit: BoxFit.contain,
                            imageUrl: getImage(
                              path: person.profilePath ?? '',
                              size: 'original',
                            ),
                          )
                        : CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: ImageEnums.celebrity.toImage,
                          ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    person.name ?? 'UNKNOWN',
                    softWrap: true,
                    style: TextStyles.robotoRegular10Style,
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    person.character ?? 'UNKNOWN',
                    style: TextStyles.robotoRegular10Style.copyWith(
                      color: Colors.white.withOpacity(0.6),
                    ),
                  )
                ],
              ).separated(
                const SizedBox(
                  height: 5,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
