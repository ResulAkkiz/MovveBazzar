import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/viewmodel/trending_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MoreTrendScreen extends StatefulWidget {
  const MoreTrendScreen({super.key, required this.items});
  final List<IBaseTrendingModel> items;

  @override
  State<MoreTrendScreen> createState() => _MoreTrendScreenState();
}

class _MoreTrendScreenState extends State<MoreTrendScreen> {
  late final TrendingViewModel trendingViewModel = context.read();
  List<IBaseTrendingModel> trendingList = [];
  int pageNumber = 1;
  bool show = true;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    trendingList = List.from(widget.items);
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    pageNumber++;
    if (!mounted) return;
    trendingList.addAll(
      await trendingViewModel.getTrendings(
        type: 'all',
        timeInterval: 'day',
        pageNumber: pageNumber,
      ),
    );

    setState(() {});
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    double maxCrossAxisExtent =
        (MediaQuery.of(context).size.shortestSide - 40.0) / 3;
    double posterAspectRatio = 10 / 16;

    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          scrollListener() {
            show = scrollController.position.userScrollDirection ==
                ScrollDirection.forward;
          }

          scrollController.addListener(scrollListener);
          return [_buildSliverAppBar()];
        },
        body: Column(
          children: [
            Visibility(
              visible: show,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36.0),
                    color: Colors.amber),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [Text('asdasd'), Text('asdasd')],
                ),
              ),
            ),
            Expanded(
              child: SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                footer: ClassicFooter(
                  loadingText: 'Loading',
                  loadStyle: LoadStyle.ShowWhenLoading,
                  textStyle: TextStyles.robotoRegular19Style,
                  failedIcon: Icon(
                    Icons.error,
                    color: Theme.of(context).primaryColor,
                  ),
                  canLoadingIcon: Icon(
                    Icons.autorenew,
                    color: Theme.of(context).primaryColor,
                  ),
                  idleIcon: Icon(
                    Icons.arrow_upward,
                    color: Theme.of(context).primaryColor,
                  ),
                  loadingIcon: SizedBox.square(
                    dimension: 24.0,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  outerBuilder: (child) => SafeArea(
                    top: false,
                    child: child,
                  ),
                ),
                controller: refreshController,
                onRefresh: onRefresh,
                onLoading: onLoading,
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    maxCrossAxisExtent: maxCrossAxisExtent,
                    mainAxisExtent:
                        (maxCrossAxisExtent / posterAspectRatio) + 24.0,
                  ),
                  itemCount: trendingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    IBaseTrendingModel currentMedia = trendingList[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: getImage(
                              path: currentMedia.posterPath ?? '',
                              size: 'w200'),
                          imageBuilder: (context, imageProvider) => AspectRatio(
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
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      title: buildAppBarLogo(),
      centerTitle: true,
      elevation: 0,
    );
  }
}


//  Column(
//         children: [
//           buildLogo(),
//           DropdownButton(items: const [
//             DropdownMenuItem(
//               value: 'TR',
//               child: Text('TR'),
//             )
//           ], onChanged: ((value) {}))
//         ],
//       ),