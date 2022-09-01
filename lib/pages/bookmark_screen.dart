import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/model/movie.dart';
import 'package:flutter_application_1/model/tv.dart';
import 'package:flutter_application_1/app_constants/ticket_widget.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(controller: _tabController, tabs: const [
          Tab(
            text: 'Movie',
          ),
          Tab(
            text: 'Tv',
          )
        ]),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildBookmarkGrid(
                  filmName: 'Pasific Rim The Black',
                  filmStarRate: '8.9',
                  filmDirector: 'Resul Akkız',
                  filmImdbRate: '9.3'),
              _buildBookmarkGrid(
                  filmName: 'Last Air Bender',
                  filmStarRate: '9.3',
                  filmDirector: 'Recep Öztürk',
                  filmImdbRate: '9.3'),
            ],
          ),
        ),
      ],
    );
  }

  GridView _buildBookmarkGrid(
      {required String filmName,
      required String filmStarRate,
      required String filmImdbRate,
      required String filmDirector}) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 240,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 10),
          child: TicketWidget(
            width: (240 * 10 / 16) + 16,
            child: Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: AspectRatio(
                      aspectRatio: 10 / 16,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ImageEnums.sampleimage2.toImagewithBoxFit),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          filmName,
                          style: TextStyles.robotoRegularBold28Style,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox.square(
                                    dimension: 25,
                                    child: IconEnums.fullstar.toImage),
                                Text(
                                  filmStarRate,
                                  style: TextStyles.robotoHeadlineStyle
                                      .copyWith(color: Colors.amber),
                                ),
                              ],
                            ).separated(
                              const SizedBox(
                                width: 5,
                              ),
                            ),
                            Chip(
                                backgroundColor: Colors.amber.shade600,
                                label: Text(
                                  'IMDB $filmImdbRate',
                                  style: TextStyles.robotoMedium16Style
                                      .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Text(filmDirector),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
