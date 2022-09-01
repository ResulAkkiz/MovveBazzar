import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/pages/bookmark_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: _buildNavbar(context),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          body: const BookMarkScreen(),
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) =>
                  [_buildSliverAppBar()],
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [IconButton(onPressed: () {}, icon: IconEnums.search.toImage)],
      title: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Mov',
              style: TextStyles.appBarTitleStyle,
            ),
            TextSpan(
              text: 've',
              style: TextStyles.appBarTitleStyle.copyWith(
                color: const Color(0xFFE11A38),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavbar(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: BottomNavyBar(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          containerHeight: MediaQuery.of(context).size.height * 0.08,
          backgroundColor: const Color(0xFFDA1A37),
          selectedIndex: _currentIndex,
          animationDuration: const Duration(milliseconds: 200),
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
              imageEnum: IconEnums.play,
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
      icon: imageEnum.toImage,
      title: Text(imageEnum.toName, style: TextStyles.navbarItemStyle),
      activeColor: const Color(0xFF420b0b),
    );
  }
}
