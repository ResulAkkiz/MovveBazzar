import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/pages/more_trends_screen.dart';
import 'package:flutter_application_1/viewmodel/trending_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomepageBody extends StatefulWidget {
  const HomepageBody({Key? key}) : super(key: key);

  @override
  State<HomepageBody> createState() => _HomepageBodyState();
}

class _HomepageBodyState extends State<HomepageBody> {
  late final TrendingViewModel trendingViewModel = context.read();
  final double posterAspectRatio = 10 / 16;

  @override
  void initState() {
    super.initState();
    trendingViewModel.getTrendings(
      type: 'all',
      timeInterval: 'day',
      pageNumber: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        bottom: 64.0 + 20.0 + 15.0,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BuildTopic(value: 'Popular Movie'),
            _buildSampleListView(),
            const BuildTopic(value: 'Tv Show'),
            _buildSampleListView(),
            BuildTopic(
              value: 'Trends',
              trailingWidget: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MoreTrendScreen(
                      items: trendingViewModel.trendingModelList,
                    ),
                  ));
                },
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  visualDensity: VisualDensity.compact,
                ),
                child: Text(
                  'see more...',
                  style: TextStyles.robotoRegular10Style,
                ),
              ),
            ),
            _buildSampleListView(),
            const BuildTopic(value: 'Trends'),
            _buildSampleListView(),
          ],
        ),
      ),
    );
  }

  Widget _buildSampleListView() {
    final trendingViewModel = Provider.of<TrendingViewModel>(context);
    return SizedBox(
      height: (MediaQuery.of(context).size.shortestSide *
              0.36 /
              posterAspectRatio) +
          64.0,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: ListView.separated(
          itemCount: trendingViewModel.trendingModelList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            IBaseTrendingModel currentMedia =
                trendingViewModel.trendingModelList[index];
            return buildMediaClip(currentMedia);
          },
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 10.0,
          ),
          separatorBuilder: (context, index) => const SizedBox(
            width: 12.0,
          ),
        ),
      ),
    );
  }

  Widget buildMediaClip(IBaseTrendingModel<dynamic> currentMedia) {
    return SizedBox(
      width: MediaQuery.of(context).size.shortestSide * 0.36,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl:
                getImage(path: currentMedia.posterPath ?? '', size: 'w200'),
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
              style: TextStyles.robotoMediumStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Flexible(
            child: Text(
              currentMedia.date == null
                  ? 'UNKNOWN'
                  : DateFormat.yMMMd().format(currentMedia.date!),
              style: TextStyles.robotoRegularStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class BuildTopic extends StatelessWidget {
  final String value;
  final Widget? trailingWidget;

  const BuildTopic({
    Key? key,
    required this.value,
    this.trailingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
      child: SizedBox(
        height: TextStyles.robotoHeadlineStyle.fontSize! * 1.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                value,
                style: TextStyles.robotoHeadlineStyle,
              ),
            ),
            if (trailingWidget != null) Flexible(child: trailingWidget!),
          ],
        ),
      ),
    );
  }
}
