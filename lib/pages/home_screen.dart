import 'dart:math';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/genre_model.dart';
import 'package:flutter_application_1/pages/bookmark_screen.dart';
import 'package:flutter_application_1/pages/homebody_screen.dart';
import 'package:flutter_application_1/pages/movie_detail_screen.dart';
import 'package:flutter_application_1/pages/profile_screen.dart';
import 'package:flutter_application_1/pages/tv_detail_screen.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:flutter_application_1/viewmodel/movier_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController controller;
  bool isDone = false;
  bool isOpened = false;
  late IBaseTrendingModel? randomTrendMedia;
  List<Genre> tvGenreList = [];
  List<Genre> movieGenreList = [];
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late PageController _pageController;
  final DragController dragController = DragController();
  late final List<Widget> _pages = [
    const HomepageBody(),
    BookMarkScreen(
      userID: context.read<MovierViewModel>().movier!.movierID,
    ),
    const ProfileScreen(),
  ];
  late final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 4 * pi)
      .chain(CurveTween(curve: Curves.bounceIn))
      .animate(controller)
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isDone = true;
      }
    });

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    ShakeDetector.autoStart(
      onPhoneShake: () {
        if (_currentIndex == 0) {
          buildRandomMediaDialog(offsetAnimation);
          getRandomTrendMedia();
          controller.forward(from: 0.0);
        }
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 200,
      shakeThresholdGravity: 2.2,
    );
    _pageController = PageController();
  }

  Future<void> getRandomTrendMedia() async {
    if (!mounted) return;
    randomTrendMedia =
        await context.read<MediaViewModel>().getRandomTrendingMedia();
    if (!mounted) return;
    await context.read<MediaViewModel>().getMovieGenre();
    if (!mounted) return;
    await context.read<MediaViewModel>().getTvGenre();

    if (tvGenreList.isEmpty && mounted) {
      tvGenreList = context.read<MediaViewModel>().tvGenreList;
      tvGenreList.removeWhere((e) => e.name == null);
    }
    if (movieGenreList.isEmpty && mounted) {
      movieGenreList = context.read<MediaViewModel>().movieGenreList;
      movieGenreList.removeWhere((e) => e.name == null);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildNavbar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: NestedScrollView(
              floatHeaderSlivers: true,
              body: _pages[_currentIndex],
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) =>
                      [_buildSliverAppBar()],
            ),
          ),
          if (_currentIndex == 0)
            DraggableWidget(
              bottomMargin: 120,
              topMargin: 134,
              intialVisibility: true,
              horizontalSpace: 15,
              shadowBorderRadius: 50,
              initialPosition: AnchoringPosition.bottomLeft,
              dragController: dragController,
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: Colors.amber.shade600,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                    icon: IconEnums.shake.toImageWHColor(
                      Colors.black,
                    ),
                    onPressed: () {
                      buildRandomMediaDialog(offsetAnimation);
                    }),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> buildRandomMediaDialog(Animation<double> offsetAnimation) async {
    if (!isOpened) {
      isOpened = true;
      showDialog(
        context: context,
        builder: (context) {
          final movierViewModel = Provider.of<MovierViewModel>(context);
          List<Genre> genreList = randomTrendMedia?.mediaType == 'tv'
              ? tvGenreList
              : movieGenreList;
          Set<String> genreNameList = genreList
              .where((value) =>
                  randomTrendMedia?.genreIds?.contains(value.id) ?? false)
              .map((e) => e.name!)
              .toSet();
          debugPrint(genreNameList.toString());
          return Stack(
            children: [
              Material(
                type: MaterialType.transparency,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 90),
                  child: AnimatedBuilder(
                    builder: (context, widget) {
                      return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(offsetAnimation.value),
                          child: isDone
                              ? GestureDetector(
                                  onTap: () {
                                    randomTrendMedia?.mediaType == 'tv'
                                        ? Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TvDetailPage(
                                                        mediaID:
                                                            randomTrendMedia!
                                                                .id!,
                                                        movierID:
                                                            movierViewModel
                                                                .movier!
                                                                .movierID)))
                                        : Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MovieDetailPage(
                                                        mediaID:
                                                            randomTrendMedia!
                                                                .id!,
                                                        movierID:
                                                            movierViewModel
                                                                .movier!
                                                                .movierID)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color:
                                            Theme.of(context).primaryColorDark),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          //'https://image.tmdb.org/t/p/original/pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg',
                                          CachedNetworkImage(
                                            imageUrl: getImage(
                                                path: randomTrendMedia
                                                    ?.posterPath,
                                                size: 'original'),
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    AspectRatio(
                                              aspectRatio: 0.8,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) {
                                              return const SizedBox.square(
                                                dimension: 250,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );
                                            },
                                          ),
                                          Text(
                                              randomTrendMedia!.mediaName
                                                  .toString(),
                                              style: TextStyles.robotoBoldStyle
                                                  .copyWith(fontSize: 25),
                                              textAlign: TextAlign.center),
                                          buildRatingBar(
                                              voteAverage: randomTrendMedia!
                                                      .voteAverage ??
                                                  0,
                                              voteCount:
                                                  randomTrendMedia!.voteCount ??
                                                      0),
                                          buildGenreList(
                                              context, genreNameList),
                                          Text(
                                            'Shake me again, if you are not pleasent from result.',
                                            style: TextStyles
                                                .robotoMedium12Style
                                                .copyWith(
                                                    fontSize: 10,
                                                    color: Colors.white
                                                        .withOpacity(0.4)),
                                          ),
                                        ],
                                      ).separated(const SizedBox(
                                        height: 5,
                                      )),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Container(
                                    height: MediaQuery.of(context)
                                            .size
                                            .longestSide *
                                        0.7,
                                    width: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.7,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.question_mark_outlined,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 150,
                                          ),
                                          Text(
                                            'Try your chance.',
                                            style:
                                                TextStyles.robotoMedium16Style,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Shake me!!',
                                            style: TextStyles.appBarTitleStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                    },
                    animation: offsetAnimation,
                  ),
                ),
              ),
            ],
          );
        },
      ).then((value) => isOpened = false);
    }
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      elevation: 0,
      actions: [IconButton(onPressed: () {}, icon: IconEnums.search.toImage)],
      title: buildAppBarLogo(),
    );
  }

  Widget _buildNavbar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: BottomNavyBar(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          containerHeight: 64.0,
          backgroundColor: const Color(0xFFDA1A37),
          selectedIndex: _currentIndex,
          animationDuration: const Duration(milliseconds: 300),
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
            if (_pageController.hasClients) {
              _pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.ease);
            }
          }),
          items: [
            _buildNavyBarItem(
              imageEnum: IconEnums.home,
            ),
            _buildNavyBarItem(
              imageEnum: IconEnums.bookmark,
            ),
            _buildNavyBarItem(
              imageEnum: IconEnums.profile,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavyBarItem _buildNavyBarItem({
    required IconEnums imageEnum,
  }) {
    return BottomNavyBarItem(
      icon: imageEnum.toImageWH,
      title: Text(imageEnum.toName, style: TextStyles.navbarItemStyle),
      activeColor: const Color(0xFF420b0b),
    );
  }
}
