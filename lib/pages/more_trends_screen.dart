import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
  List<IBaseTrendingModel> trendingList = [];
  int pageNumber = 1;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    trendingList = widget.items;
    super.initState();
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    pageNumber++;
    debugPrint(pageNumber.toString());
    if (mounted) {
      trendingList.addAll(
        await context.read<TrendingViewModel>().getTrendings(
              type: 'all',
              timeInterval: 'day',
              pageNumber: pageNumber.toString(),
            ),
      );

      setState(() {});
    }
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final trendingViewModel = Provider.of<TrendingViewModel>(context);
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) =>
          [_buildSliverAppBar()],
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
          canLoadingIcon:
              Icon(Icons.autorenew, color: Theme.of(context).primaryColor),
          idleIcon:
              Icon(Icons.arrow_upward, color: Theme.of(context).primaryColor),
        ),
        controller: refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 10,
            maxCrossAxisExtent: MediaQuery.of(context).size.shortestSide * 0.4,
            mainAxisExtent: MediaQuery.of(context).size.shortestSide * 0.6,
          ),
          itemCount: trendingList.length,
          itemBuilder: (BuildContext context, int index) {
            IBaseTrendingModel currentMedia = trendingList[index];
            return SizedBox(
              width: MediaQuery.of(context).size.shortestSide * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.shortestSide * 0.3,
                    height: MediaQuery.of(context).size.shortestSide * 0.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        getImage(
                            path: currentMedia.posterPath ?? '', size: 'w500'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    currentMedia.mediaName ?? 'UNKNOWN',
                    style: TextStyles.robotoMedium12Style,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ));
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      centerTitle: true,
      floating: true,
      snap: true,
      elevation: 0,
      title: buildAppBarLogo(),
    );
  }
}
