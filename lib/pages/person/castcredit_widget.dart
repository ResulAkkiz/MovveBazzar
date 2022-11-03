import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/model/castcredit_model.dart';

import 'package:flutter_application_1/pages/person/castcredit_list_view.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';

import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class CardCreditWidget extends StatefulWidget {
  final int personID;
  final PaletteGenerator? palette;

  const CardCreditWidget(
    this.personID, {
    Key? key,
    this.palette,
  }) : super(key: key);

  @override
  State<CardCreditWidget> createState() => _CardCreditWidgetState();
}

class _CardCreditWidgetState extends State<CardCreditWidget> {
  @override
  void initState() {
    context.read<MediaViewModel>().getCastCreditbyPersonID(widget.personID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaViewModel mediaViewModel = context.watch<MediaViewModel>();
    List<CastCredit> castCreditList = mediaViewModel.castCreditList;
    debugPrint(
        'CastCredit widgettaki eleman sayısı + ${castCreditList.length}');
    return castCreditList.isEmpty
        ? const SizedBox.shrink()
        : Column(
            children: [
              buildTitle('Productions'),
              SizedBox(
                height: 250,
                child: CastCreditListView(
                  castCreditList: castCreditList,
                  palette: widget.palette,
                ),
              ),
            ],
          );
  }
}
