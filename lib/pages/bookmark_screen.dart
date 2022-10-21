import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:cool_alert/src/constants/images.dart';
import 'package:cool_alert/src/utils/animate.dart';
import 'package:cool_alert/src/utils/single_loop_controller.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/ticket_widget.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/model/bookmark_model.dart';
import 'package:flutter_application_1/viewmodel/bookmark_view_model.dart';

class BookMarkScreen extends StatefulWidget {
  final String userID;
  const BookMarkScreen({super.key, required this.userID});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    context.read<BookmarkViewModel>().getBookMarks(widget.userID);
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(controller: _tabController, tabs: const [
          Tab(
            text: 'Movie',
          ),
          Tab(
            text: 'Tv',
          )
        ]),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildBookmarkGrid('movie'),
              _buildBookmarkGrid('tv'),
            ],
          ),
        ),
      ],
    );
  }

  GridView _buildBookmarkGrid(String type) {
    final bookmarkViewModel = Provider.of<BookmarkViewModel>(context);
    List<BookMark> bookmarkList = (bookmarkViewModel.bookmarkList
        .where((element) => element.mediaType == type)).toList();
    return GridView.builder(
      padding: EdgeInsets.only(
        top: 10.0,
        bottom: 64.0 + 20.0 + 10.0 + MediaQuery.of(context).padding.bottom,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 208,
      ),
      itemCount: bookmarkList.length,
      itemBuilder: (context, index) {
        BookMark currentBookmark = bookmarkList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              TicketWidget(
                width: (208 * 10 / 16) + 16,
                child: Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: AspectRatio(
                          aspectRatio: 10 / 16,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: getImage(
                                    path: currentBookmark.imagePath,
                                    size: 'original'),
                              )),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentBookmark.mediaName,
                              style: TextStyles.robotoRegularBold24Style,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (currentBookmark.mediaVote != null)
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox.square(
                                          dimension: 20,
                                          child: IconEnums.fullstar.toImage),
                                      Text(
                                        currentBookmark.mediaVote!
                                            .toStringAsFixed(1),
                                        style: TextStyles.robotoBold18Style
                                            .copyWith(color: Colors.amber),
                                      ),
                                    ],
                                  ).separated(
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ),
                                Chip(
                                    backgroundColor: Colors.amber.shade600,
                                    label: Text(
                                      DateFormat('dd/MM/yyyy').format(
                                          currentBookmark.date ??
                                              DateTime.now()),
                                      style: TextStyles.robotoRegular12Style
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                    ))
                              ],
                            ),
                            Text(
                              'Runtime: ${currentBookmark.runtime} min',
                              style: TextStyles.robotoMedium12Style,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  bool? isSuccess = await bookmarkViewModel.deleteBookmark(
                      widget.userID, currentBookmark.mediaID);

                  bookmarkViewModel.getBookMarks(widget.userID);
                  if (mounted) {
                    if (isSuccess) {
                      showCoolerDialog(context, types: CoolAlertType.success);
                    } else {
                      showCoolerDialog(context, types: CoolAlertType.error);
                    }
                  }
                },
                icon: const Icon(Icons.close),
                splashColor: Colors.transparent,
              ),
            ],
          ),
        );
      },
    );
  }

  void showCoolerDialog(
    BuildContext context, {
    int? seconds = 2,
    CoolAlertType types = CoolAlertType.success,
  }) {
    if (seconds != null) {
      Future.delayed(Duration(seconds: seconds), () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    }

    Widget buildHeader(context) {
      CoolAlertType type = types;

      String? anim = AppAnim.success;

      switch (type) {
        case CoolAlertType.success:
          anim = AppAnim.success;
          break;
        case CoolAlertType.error:
          anim = AppAnim.error;
          break;
        case CoolAlertType.warning:
          anim = AppAnim.warning;
          break;
        case CoolAlertType.confirm:
          anim = AppAnim.info;
          break;
        case CoolAlertType.info:
          anim = AppAnim.info;
          break;
        case CoolAlertType.loading:
          anim = AppAnim.loading;
          break;
        default:
          anim = AppAnim.info;
      }

      return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: SizedBox(
          height: 200,
          width: 200,
          child: FlareActor(
            anim,
            animation: type == CoolAlertType.loading ? 'play' : null,
            controller: type == CoolAlertType.loading
                ? null
                : SingleLoopController(
                    'play',
                    1,
                  ),
            //color: Colors.black, we'll use this line for loading situation.
          ),
        ),
      );
    }

    showGeneralDialog(
      transitionBuilder: (context, anim1, __, widget) {
        return Animate.scale(
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: buildHeader(context),
          ),
          animation: anim1,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, _, __) => Container(),
    );
  }
}
