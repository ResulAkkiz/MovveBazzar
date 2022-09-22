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
  @override
  void initState() {
    context
        .read<TrendingViewModel>()
        .getTrendings(type: 'all', timeInterval: 'day', pageNumber: '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        0,
        15.0,
        0,
        MediaQuery.of(context).size.shortestSide * 0.3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BuildTopic(value: 'Popular Movie'),
          _buildSampleListView(context),
          const BuildTopic(value: 'Tv Show'),
          _buildSampleListView(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BuildTopic(value: 'Trends'),
              SizedBox(
                height: MediaQuery.of(context).size.shortestSide * 0.1,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MoreTrendScreen(),
                      ));
                    },
                    child: Text(
                      'see more...      ',
                      style: TextStyles.robotoRegular10Style,
                    )),
              )
            ],
          ),
          _buildSampleListView(context),
          const BuildTopic(value: 'Trends'),
          _buildSampleListView(context),
        ],
      ),
    );
  }

  Padding _buildSampleListView(BuildContext context) {
    final trendingViewModel = Provider.of<TrendingViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.shortestSide * 0.65,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: ListView.builder(
              itemCount: trendingViewModel.trendingModelList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                IBaseTrendingModel currentMedia =
                    trendingViewModel.trendingModelList[index];
                return Padding(
                    padding:
                        index == trendingViewModel.trendingModelList.length - 1
                            ? const EdgeInsets.fromLTRB(12, 0, 12, 0)
                            : const EdgeInsets.only(left: 12),
                    child: buildMediaClip(currentMedia));
              }),
        ),
      ),
    );
  }

  Widget buildMediaClip(IBaseTrendingModel<dynamic> currentMedia) {
    return SizedBox(
      width: MediaQuery.of(context).size.shortestSide * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.shortestSide * 0.35,
            height: MediaQuery.of(context).size.shortestSide * 0.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                getImage(path: currentMedia.posterPath ?? '', size: 'w200'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Flexible(
            child: Text(
              currentMedia.mediaName ?? 'UNKNOWN',
              style: TextStyles.robotoMediumStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Text(
            currentMedia.date == null
                ? 'UNKNOWN'
                : DateFormat.yMMMd().format(currentMedia.date!),
            style: TextStyles.robotoRegularStyle,
          ),
        ],
      ),
    );
  }
}

class BuildTopic extends StatelessWidget {
  final String value;
  const BuildTopic({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        value,
        style: TextStyles.robotoHeadlineStyle,
      ),
    );
  }
}


//  Text((currentMedia is MovieTrending? currentMedia.title :
//               (currentMedia as TvTrending).name) ?? 'UNKNOWN',
//               style: TextStyles.robotoMediumStyle,
//             ),