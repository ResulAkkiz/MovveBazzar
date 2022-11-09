import 'dart:math';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/model/base_trending_show_model.dart';
import 'package:flutter_application_1/pages/bookmark_screen.dart';
import 'package:flutter_application_1/pages/homebody_screen.dart';
import 'package:flutter_application_1/pages/media_detail_screen.dart';
import 'package:flutter_application_1/pages/profile_screen.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
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
  late final AnimationController controller;
  bool isDone = false;
  bool isOpened = false;
  IBaseTrendingShowModel? randomTrendMedia;
  IBaseTrendingShowModel? previousRandomTrendMedia;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final PageController pageController = PageController();
  final DragController dragController = DragController();
  late final List<Widget> _pages = [
    const HomepageBody(),
    const BookMarkScreen(),
    const ProfileScreen(),
  ];
  late final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 6 * pi)
      .chain(CurveTween(curve: Curves.easeOut))
      .animate(controller)
    ..addStatusListener((status) {
      isDone = status == AnimationStatus.completed;
    });

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    getRandomTrendMedia();
    ShakeDetector.autoStart(
      onPhoneShake: () {
        if (_currentIndex == 0 &&
            (ModalRoute.of(context)!.isCurrent || isOpened)) {
          debugPrint('if içi');
          buildRandomMediaDialog();
          getRandomTrendMedia();
        }
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 600,
      shakeThresholdGravity: 2.2,
    );
  }

  Future<void> getRandomTrendMedia() async {
    controller.forward(from: 0.0);
    previousRandomTrendMedia = randomTrendMedia;
    randomTrendMedia =
        await context.read<MediaViewModel>().getRandomTrendingMedia();
  }

  @override
  void dispose() {
    pageController.dispose();
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
              child: CircleAvatar(
                radius: 32,
                backgroundColor: Colors.amber.shade600,
                child: IconButton(
                  iconSize: 24.0,
                  icon: IconEnums.shake.toIcon(
                    color: Colors.black,
                  ),
                  onPressed: buildRandomMediaDialog,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> buildRandomMediaDialog() async {
    if (!isOpened) {
      isOpened = true;
      isDone = false;
      previousRandomTrendMedia = null;
      randomTrendMedia = null;
      await showDialog(
        context: context,
        builder: (context) {
          return Material(
            type: MaterialType.transparency,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(
                  vertical: 32.0,
                  horizontal: 42.0,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 64,
                        bottom: 16.0,
                      ),
                      child: AnimatedBuilder(
                        builder: (context, widget) {
                          return GestureDetector(
                            onVerticalDragUpdate: (details) {
                              if ((details.primaryDelta ?? 0).abs() > 20) {
                                Navigator.of(context).pop();
                              }
                            },
                            onHorizontalDragUpdate: (details) {
                              if ((details.primaryDelta ?? 0).abs() > 20) {
                                getRandomTrendMedia();
                              }
                            },
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(offsetAnimation.value),
                              child: isDone
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                          ..pop()
                                          ..push(MaterialPageRoute(
                                            builder: (context) =>
                                                MediaDetailPage(
                                              randomTrendMedia!.id!,
                                              mediaType:
                                                  randomTrendMedia!.mediaType!,
                                            ),
                                          ));
                                      },
                                      child: randomMediaCard(randomTrendMedia!),
                                    )
                                  : previousRandomTrendMedia == null
                                      ? buildRandomMediaBrief(context)
                                      : randomMediaCard(
                                          previousRandomTrendMedia!),
                            ),
                          );
                        },
                        animation: offsetAnimation,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topCenter,
                      child: CloseButton(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        backgroundColor: Colors.amber.shade600,
                        foregroundColor: Colors.black,
                        child: IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: getRandomTrendMedia,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
      isOpened = false;
    }
  }

  Container buildRandomMediaBrief(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      width: isLandscape ? null : MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColorDark,
      ),
      padding: const EdgeInsets.all(15.0),
      child: Flex(
        mainAxisSize: isLandscape ? MainAxisSize.min : MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        direction: isLandscape ? Axis.horizontal : Axis.vertical,
        children: [
          Icon(
            Icons.question_mark_outlined,
            color: Theme.of(context).primaryColor,
            size: MediaQuery.of(context).size.shortestSide * 0.2,
          ),
          Column(
            crossAxisAlignment: isLandscape
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Try your chance.',
                style: TextStyles.robotoMedium16Style,
              ),
              Text(
                'Shake me!',
                style: TextStyles.appBarTitleStyle,
              ),
            ],
          ).separated(
            const SizedBox(
              height: 15,
            ),
          )
        ],
      ).separated(
        const SizedBox(
          height: 15,
        ),
      ),
    );
  }

  Widget randomMediaCard(IBaseTrendingShowModel media) {
    const aspectRatio = 10 / 16;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).primaryColorDark,
      ),
      child: Flex(
        mainAxisSize: isLandscape ? MainAxisSize.min : MainAxisSize.max,
        mainAxisAlignment:
            isLandscape ? MainAxisAlignment.center : MainAxisAlignment.start,
        direction: isLandscape ? Axis.horizontal : Axis.vertical,
        children: [
          if (media.posterPath != null)
            AspectRatio(
              aspectRatio: aspectRatio,
              child: CachedNetworkImage(
                imageUrl: getImage(
                  path: media.posterPath,
                  size: 'original',
                ),
                imageBuilder: (context, imageProvider) => DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment: isLandscape
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(media.mediaName.toString(),
                    style: TextStyles.robotoBoldStyle.copyWith(fontSize: 20),
                    textAlign: TextAlign.center),
                buildRatingBar(
                    voteAverage: media.voteAverage ?? 0,
                    voteCount: media.voteCount ?? 0),
                buildGenreList(context),
                Text(
                  'Shake me again, if you are not pleasant from result.',
                  style: TextStyles.robotoMedium12Style.copyWith(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          )
        ],
      ).separated(
        const SizedBox.square(
          dimension: 15,
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      floating: true,
      snap: true,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: IconEnums.search.toIcon(),
        )
      ],
      title:
          SizedBox(width: 150, height: 50, child: ImageEnums.applogo.toImage),
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
            if (pageController.hasClients) {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 150),
                curve: Curves.ease,
              );
            }
          }),
          items: [
            _buildNavyBarItem(IconEnums.home),
            _buildNavyBarItem(IconEnums.bookmark),
            _buildNavyBarItem(IconEnums.profile),
          ],
        ),
      ),
    );
  }

  BottomNavyBarItem _buildNavyBarItem(IconEnums imageEnum) {
    return BottomNavyBarItem(
      icon: imageEnum.toIcon(dimension: 28.0),
      title: Text(
        imageEnum.toName,
        style: TextStyles.navbarItemStyle,
      ),
      activeColor: const Color(0xFF420b0b),
    );
  }
}
