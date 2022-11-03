import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/model/people_model.dart';
import 'package:flutter_application_1/pages/person/castcredit_list_view.dart';
import 'package:palette_generator/palette_generator.dart';

class CardCreditWidget extends StatefulWidget {
  final Person person;
  final PaletteGenerator? palette;

  const CardCreditWidget(
    this.person, {
    Key? key,
    this.palette,
  }) : super(key: key);

  @override
  State<CardCreditWidget> createState() => _CardCreditWidgetState();
}

class _CardCreditWidgetState extends State<CardCreditWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Person? person = widget.person;
    String genderAct = person.gender == 1 ? 'Actress' : 'Actor';

    return person.combinedCredits!.cast!.isEmpty
        ? const SizedBox.shrink()
        : Column(
            children: [
              buildCastCardTitle('Productions Taking Role the $genderAct'),
              SizedBox(
                height: 250,
                child: CastCreditListView(
                  castCreditList: person.combinedCredits!.cast,
                  palette: widget.palette,
                ),
              ),
            ],
          );
  }

  Container buildCastCardTitle(String text) {
    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        top: 15,
      ),
      alignment: Alignment.centerLeft,
      child: Text(text, style: TextStyles.robotoRegularBold22Style),
    );
  }
}
