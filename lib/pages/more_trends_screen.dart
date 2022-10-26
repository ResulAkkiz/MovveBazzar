import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/pages/media_detail_screen.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MoreTrendScreen extends StatefulWidget {
  const MoreTrendScreen({super.key, required this.items});
  final List<IBaseTrendingModel> items;

  @override
  State<MoreTrendScreen> createState() => _MoreTrendScreenState();
}

class _MoreTrendScreenState extends State<MoreTrendScreen> {
  late final MediaViewModel mediaViewModel = context.read<MediaViewModel>();
  final ScrollController _controller = ScrollController();
  List<IBaseTrendingModel> trendingList = [];
  int pageNumber = 1;
  String timeInterval = 'day';
  String type = 'all';

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

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
      await mediaViewModel.getTrendings(
        type: type,
        timeInterval: timeInterval,
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
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildSliverAppBar(),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: Delegate(Colors.transparent, buildRowDropButton()),
          )
        ],
        body: SmartRefresher(
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
            loadingIcon: const SizedBox.square(
              dimension: 24.0,
              child: CircularProgressIndicator(),
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
            controller: _controller,
            padding: const EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: 10,
              mainAxisSpacing: 30,
              maxCrossAxisExtent: maxCrossAxisExtent,
              mainAxisExtent: (maxCrossAxisExtent / posterAspectRatio) + 24.0,
            ),
            itemCount: trendingList.length,
            itemBuilder: (BuildContext context, int index) {
              IBaseTrendingModel currentMedia = trendingList[index];
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
                    CachedNetworkImage(
                      imageUrl:
                          getImage(path: currentMedia.posterPath, size: 'w200'),
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
                ),
              );
            },
          ),
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

  Widget buildRowDropButton() {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildMoreTrendsDDB(
            value: timeInterval,
            items: const [
              DropdownMenuItem(
                value: 'day',
                child: Text('Day'),
              ),
              DropdownMenuItem(
                value: 'week',
                child: Text('Week'),
              ),
            ],
            onChanged: (String? value) async {
              trendingList = [];
              timeInterval = value!;
              pageNumber = 1;

              trendingList = await mediaViewModel.getTrendings(
                  type: type,
                  timeInterval: timeInterval,
                  pageNumber: pageNumber);
              setState(() {
                _scrollUp();
              });
            }),
        buildMoreTrendsDDB(
            value: type,
            items: const [
              DropdownMenuItem(
                value: 'all',
                child: Text('All'),
              ),
              DropdownMenuItem(
                value: 'tv',
                child: Text('Tv'),
              ),
              DropdownMenuItem(
                value: 'movie',
                child: Text('Movie'),
              ),
            ],
            onChanged: (String? value) async {
              trendingList = [];
              type = value!;
              pageNumber = 1;

              trendingList = await mediaViewModel.getTrendings(
                  type: type,
                  timeInterval: timeInterval,
                  pageNumber: pageNumber);
              setState(() {
                _scrollUp();
              });
            }),
      ],
    ));
  }

  void _scrollUp() {
    _controller.jumpTo(0);
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Color backgroundColor;
  final Widget child;

  Delegate(this.backgroundColor, this.child);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
