import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/pages/bookmark_screen.dart';
import 'package:flutter_application_1/pages/homebody_screen.dart';
import 'package:flutter_application_1/pages/profile_screen.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late PageController _pageController;
  final List<Widget> _pages = [
    const HomepageBody(),
    const BookMarkScreen(),
    const ProfileScreen(),
  ];

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
    //final trendingViewModel = Provider.of<TrendingViewModel>(context);
    return Scaffold(
      floatingActionButton: _buildNavbar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        bottom: false,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          body: _pages[_currentIndex],
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
      icon: imageEnum.toImage,
      title: Text(imageEnum.toName, style: TextStyles.navbarItemStyle),
      activeColor: const Color(0xFF420b0b),
    );
  }
}
