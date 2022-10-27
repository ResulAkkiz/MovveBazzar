import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/app_constants/palette_function.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/model/review_model.dart';
import 'package:flutter_application_1/model/type_definitions.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class ReviewsWidget extends StatefulWidget {
  final Id mediaID;
  final String mediaType;
  final PaletteGenerator? palette;

  const ReviewsWidget(
    this.mediaID,
    this.mediaType, {
    Key? key,
    this.palette,
  }) : super(key: key);

  @override
  State<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  @override
  void initState() {
    super.initState();

    context
        .read<MediaViewModel>()
        .getReviewsbyMediaID(widget.mediaID, 1, widget.mediaType);
  }

  @override
  Widget build(BuildContext context) {
    final MediaViewModel mediaViewModel = context.watch<MediaViewModel>();
    final PaletteGenerator? palette = widget.palette;

    return mediaViewModel.reviewList.isNotEmpty
        ? Container(
            height: MediaQuery.of(context).size.shortestSide * 0.9,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: palette?.primaryColor?.color ??
                  Theme.of(context).primaryColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: PageView.builder(
              itemCount: mediaViewModel.reviewList.length,
              itemBuilder: (context, index) {
                Review currentReview = mediaViewModel.reviewList[index];

                return Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    Positioned(
                      left: 20,
                      child: Container(
                        width:
                            (MediaQuery.of(context).size.shortestSide * 0.33) -
                                20,
                        height: MediaQuery.of(context).size.shortestSide * 0.75,
                        decoration: BoxDecoration(
                          color: palette?.mutedColor?.color ?? Colors.black45,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.33,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.6,
                            decoration: BoxDecoration(
                              color: palette?.lightVibrantColor?.color ??
                                  Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 25, 10, 32),
                              child: Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: CachedNetworkImage(
                                      errorWidget: (context, url, error) {
                                        return const Icon(Icons.dangerous);
                                      },
                                      imageUrl: currentReview
                                                  .authorDetails!.avatarPath !=
                                              null
                                          ? (currentReview
                                                  .authorDetails!.avatarPath!
                                                  .startsWith('/https://www')
                                              ? currentReview
                                                  .authorDetails!.avatarPath!
                                                  .substring(1)
                                              : getImage(
                                                  path: currentReview
                                                      .authorDetails!
                                                      .avatarPath!,
                                                  size: 'original',
                                                ))
                                          : 'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=1060&t=st=1665151999~exp=1665152599~hmac=7ed5078bf5502eaefe2f23995ac6a2004ee9c97a62a98084e2e094cdf6178abd',
                                    ),
                                  ),
                                  Text(
                                    currentReview.author ?? '',
                                    style:
                                        TextStyles.robotoBold18Style.copyWith(
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.8,
                            width: MediaQuery.of(context).size.width -
                                (MediaQuery.of(context).size.shortestSide *
                                        0.33 +
                                    40),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Reviews',
                                    style: TextStyles.robotoRegularBold24Style
                                        .copyWith(
                                      color:
                                          palette?.primaryColor?.bodyTextColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    currentReview.content!,
                                    overflow: TextOverflow.fade,
                                    style: TextStyles.robotoRegular10Style
                                        .copyWith(
                                      color:
                                          palette?.primaryColor?.bodyTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        : const SizedBox.shrink();
  }
}
