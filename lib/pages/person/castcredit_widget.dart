import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/model/castcredit_model.dart';

import 'package:flutter_application_1/pages/person/castcredit_list_view.dart';

import 'package:palette_generator/palette_generator.dart';

class CardCreditWidget extends StatelessWidget {
  final List<CastCredit>? castCreditList;
  final PaletteGenerator? palette;

  const CardCreditWidget(
    this.castCreditList, {
    Key? key,
    this.palette,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Gelen Credit Liste : ${castCreditList?.length}');
    return castCreditList?.isEmpty ?? true
        ? const SizedBox.shrink()
        : Column(
            children: [
              buildTitle('Productions'),
              SizedBox(
                height: 250,
                child: CastCreditListView(
                  castCreditList: castCreditList,
                  palette: palette,
                ),
              ),
            ],
          );
  }
}
