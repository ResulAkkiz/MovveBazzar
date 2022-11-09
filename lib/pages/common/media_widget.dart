import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/base_page.dart';
import 'package:flutter_application_1/model/media_base_model.dart';
import 'package:flutter_application_1/model/media_images_model.dart';
import 'package:flutter_application_1/model/media_videos_model.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MediaWidget extends StatefulWidget {
  final int mediaID;
  final String mediaType;
  final PaletteGenerator? palette;

  const MediaWidget(
    this.mediaID,
    this.mediaType,
    this.palette, {
    Key? key,
  }) : super(key: key);

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends BaseState<MediaWidget> {
  List<MediaBase> mediaList = [];

  @override
  void initState() {
    super.initState();

    reload();
  }

  void reload() {
    context
        .read<MediaViewModel>()
        .getMediasbyMediaID(widget.mediaID, widget.mediaType)
        .then((value) => setState(() {
              mediaList = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    Color? color = widget.palette?.darkMutedColor?.color ??
        Theme.of(context).scaffoldBackgroundColor;
    return mediaList.isEmpty
        ? const SizedBox.shrink()
        : AspectRatio(
            aspectRatio: 16 / 9,
            child: PageView.builder(
              itemCount: mediaList.length,
              itemBuilder: (context, index) {
                MediaBase currentMedia = mediaList[index];

                if (currentMedia is MediaImage) {
                  return SizedBox(
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
                  return YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      actionsPadding: const EdgeInsets.all(12),
                      bottomActions: [
                        CurrentPosition(),
                        const SizedBox(
                          width: 12,
                        ),
                        ProgressBar(
                          isExpanded: true,
                          colors: ProgressBarColors(
                              playedColor: color, handleColor: color),
                        ),
                      ],
                      showVideoProgressIndicator: true,
                      controller: YoutubePlayerController(
                        flags: const YoutubePlayerFlags(
                          autoPlay: false,
                          mute: true,
                          disableDragSeek: true,
                        ),
                        initialVideoId: currentMedia.key!,
                      ),
                    ),
                    builder: (context, player) {
                      return player;
                    },
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
