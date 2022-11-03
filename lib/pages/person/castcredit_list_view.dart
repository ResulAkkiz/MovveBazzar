import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/model/castcredit_model.dart';

import 'package:flutter_application_1/pages/media_detail_screen.dart';

import 'package:flutter_application_1/pages/person/castcredit_card_widget.dart';

import 'package:palette_generator/palette_generator.dart';

class CastCreditListView extends StatefulWidget {
  final PaletteGenerator? palette;
  final List<Cast>? castCreditList;

  const CastCreditListView({
    Key? key,
    this.palette,
    this.castCreditList,
  }) : super(key: key);

  @override
  State<CastCreditListView> createState() => _CastCreditListViewState();
}

class _CastCreditListViewState extends State<CastCreditListView> {
  int expandedIndex = 0;

  late List<Cast>? castCreditList = widget.castCreditList;

  @override
  Widget build(BuildContext context) {
    PaletteGenerator? palette = widget.palette;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: castCreditList?.length,
      itemBuilder: (context, index) {
        Cast currentCastCredit = castCreditList![index];

        String url = getImage(
          path: currentCastCredit.posterPath,
          size: 'original',
        );

        ImageProvider image = CachedNetworkImageProvider(url);

        return CastCreditCardWidget(
          index: index,
          expandedIndex: expandedIndex,
          castCredit: currentCastCredit,
          image: image,
          palette: palette,
          onTap: () {
            expandedIndex = index;
            if (mounted) {
              setState(() {});
            }
          },
          onLongPress: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MediaDetailPage(currentCastCredit.id,
                  mediaType: currentCastCredit.mediaType!),
            ));
          },
        );
      },
    );
  }
}
