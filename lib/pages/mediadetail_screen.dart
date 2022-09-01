import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MediaDetailPage extends StatelessWidget {
  const MediaDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildDetailAppBar(),
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              ImageEnums.samplebodyimage.toImage,
              Positioned(
                top: MediaQuery.of(context).size.width,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Theme.of(context).scaffoldBackgroundColor,
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Wonder Women',
                        style: TextStyles.robotoBoldStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '2020 Adventure, Action 2 h 35 min',
                            style: TextStyles.robotoRegular16Style,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '7.2',
                            style: TextStyles.robotoMedium18Style
                                .copyWith(color: const Color(0xFFFDC432)),
                          ),
                          RatingBar(
                            itemSize: 18,
                            initialRating: 2,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            onRatingUpdate: (rating) {
                              debugPrint(rating.toString());
                            },
                            ratingWidget: RatingWidget(
                              full: IconEnums.fullstar.toImage,
                              half: IconEnums.fullstar.toImage,
                              empty: IconEnums.emptystar.toImage,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).separated(
                    const SizedBox(
                      height: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text(
                  'Wonder Woman squares off against Maxwell Lord and the Cheetah, a villainess who possesses superhuman strength and agility.',
                  style: TextStyles.robotoRegular19Style
                      .copyWith(color: Colors.white.withOpacity(0.6)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Cast',
                    style: TextStyles.robotoMedium18Style,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: MediaQuery.of(context).size.width / 6,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    itemExtent: 80,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCastColumn().separated(
                        const SizedBox(
                          height: 3,
                        ),
                      ),
                      _buildCastColumn().separated(
                        const SizedBox(
                          height: 3,
                        ),
                      ),
                      _buildCastColumn().separated(
                        const SizedBox(
                          height: 3,
                        ),
                      ),
                      _buildCastColumn().separated(
                        const SizedBox(
                          height: 3,
                        ),
                      ),
                      _buildCastColumn().separated(
                        const SizedBox(
                          height: 3,
                        ),
                      ),
                      _buildCastColumn().separated(
                        const SizedBox(
                          height: 3,
                        ),
                      ),
                      _buildCastColumn().separated(
                        const SizedBox(
                          height: 3,
                        ),
                      ),
                      _buildCastColumn().separated(
                        const SizedBox(
                          height: 3,
                        ),
                      ),
                      _buildCastColumn().separated(
                        const SizedBox(
                          height: 3,
                        ),
                      ),
                      _buildCastColumn().separated(
                        const SizedBox(
                          height: 3,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Column _buildCastColumn() {
    return Column(
      children: [
        CircleAvatar(
          radius: 24.5,
          backgroundImage: AssetImage(
            ImageEnums.samplecast.toPath,
          ),
        ),
        Text(
          'Gal Gadot',
          style: TextStyles.robotoRegular10Style,
        ),
        Text(
          'Wonder women',
          style: TextStyles.robotoRegular10Style
              .copyWith(color: Colors.white.withOpacity(0.6)),
        )
      ],
    );
  }

  AppBar _buildDetailAppBar() {
    return AppBar(
      leading: IconButton(
        icon: IconEnums.backarrow.toImage,
        onPressed: () {},
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(onPressed: () {}, icon: IconEnums.bookmark.toImage),
      ],
    );
  }
}
