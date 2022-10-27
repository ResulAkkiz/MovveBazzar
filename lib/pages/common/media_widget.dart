import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/model/media_base_model.dart';
import 'package:flutter_application_1/model/media_images_model.dart';
import 'package:flutter_application_1/model/media_videos_model.dart';
import 'package:flutter_application_1/model/type_definitions.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MediaWidget extends StatefulWidget {
  final Id mediaID;
  final String mediaType;

  const MediaWidget(this.mediaID, this.mediaType, {Key? key}) : super(key: key);

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  @override
  void initState() {
    super.initState();

    context
        .read<MediaViewModel>()
        .getMediasbyMediaID(widget.mediaID, widget.mediaType);
  }

  @override
  Widget build(BuildContext context) {
    final MediaViewModel mediaViewModel = context.watch<MediaViewModel>();

    return mediaViewModel.mediaList?.isEmpty ?? true
        ? const SizedBox.shrink()
        : SizedBox(
            height: MediaQuery.of(context).size.shortestSide * 0.7,
            child: PageView.builder(
              itemCount: mediaViewModel.mediaList?.length,
              itemBuilder: (context, index) {
                MediaBase currentMedia = mediaViewModel.mediaList![index];

                if (currentMedia is MediaImage) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.shortestSide * 0.7,
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child: SizedBox.square(
                          dimension:
                              MediaQuery.of(context).size.shortestSide * 0.2,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                      imageUrl: getImage(
                        path: currentMedia.filePath!,
                        size: 'original',
                      ),
                    ),
                  );
                }

                if (currentMedia is MediaVideo) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.shortestSide * 0.7,
                    child: YoutubePlayer(
                      controller: YoutubePlayerController(
                        flags: const YoutubePlayerFlags(
                          autoPlay: true,
                          mute: true,
                          disableDragSeek: true,
                        ),
                        initialVideoId: currentMedia.key!,
                      ),
                    ),
                  );
                }

                return const Center(
                  child: SizedBox.square(
                    dimension: 50,
                    child: Icon(Icons.warning),
                  ),
                );
              },
            ),
          );
  }
}
