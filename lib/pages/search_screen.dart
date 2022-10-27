import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/base_trending_show_model.dart';
import 'package:flutter_application_1/model/people_search_model.dart';
import 'package:flutter_application_1/model/people_trending_model.dart';
import 'package:flutter_application_1/pages/media_detail_screen.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mediaViewModel = Provider.of<MediaViewModel>(context);
    double maxCrossAxisExtent =
        (MediaQuery.of(context).size.shortestSide - 40.0) / 3;
    double posterAspectRatio = 10 / 16;

    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        mediaViewModel.searchQueries(value, '1');
                      },
                      controller: controller,
                      cursorColor: Colors.red,
                      decoration: const InputDecoration(
                          hintText: 'Search',
                          contentPadding: EdgeInsets.fromLTRB(74, 12, 10, 12)),
                    ),
                    const CircleAvatar(
                      radius: 32,
                      child: Icon(
                        Icons.search_rounded,
                        size: 48,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 550,
                  child: GridView.builder(
                    itemCount: mediaViewModel.queryResultList!.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 30,
                      maxCrossAxisExtent: maxCrossAxisExtent,
                      mainAxisExtent:
                          (maxCrossAxisExtent / posterAspectRatio) + 24.0,
                    ),
                    itemBuilder: (context, index) {
                      IBaseTrendingModel currentMedia =
                          mediaViewModel.queryResultList![index];
                      late String? posterPath;
                      if (currentMedia is IBaseTrendingShowModel) {
                        posterPath = currentMedia.posterPath;
                      } else if (currentMedia is PeopleTrending) {
                        posterPath = currentMedia.profilePath;
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return MediaDetailPage(
                                  currentMedia.id!,
                                  mediaType: currentMedia.mediaType!,
                                );
                              },
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (posterPath != null)
                              CachedNetworkImage(
                                imageUrl:
                                    getImage(path: posterPath, size: 'w200'),
                                imageBuilder: (context, imageProvider) =>
                                    AspectRatio(
                                  aspectRatio: posterAspectRatio,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Flexible(
                              child: Text(
                                currentMedia.mediaName ?? 'UNKNOWN',
                                style: TextStyles.robotoMedium12Style,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
