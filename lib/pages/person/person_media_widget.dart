import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_function.dart';
import 'package:flutter_application_1/model/media_base_model.dart';
import 'package:flutter_application_1/model/media_images_model.dart';
import 'package:flutter_application_1/model/media_videos_model.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PersonMediaWidget extends StatefulWidget {
  final int mediaID;

  const PersonMediaWidget(this.mediaID, {Key? key}) : super(key: key);

  @override
  State<PersonMediaWidget> createState() => _PersonMediaWidgetState();
}

class _PersonMediaWidgetState extends State<PersonMediaWidget> {
  @override
  void initState() {
    super.initState();

    context.read<MediaViewModel>().getMediasbyMediaID(widget.mediaID, 'person');
  }

  @override
  Widget build(BuildContext context) {
    final MediaViewModel mediaViewModel = context.watch<MediaViewModel>();

    return mediaViewModel.mediaList.isEmpty
        ? const SizedBox.shrink()
        : Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 2)),
            child: SizedBox(
              height: MediaQuery.of(context).size.shortestSide * 0.7,
              child: PageView.builder(
                itemCount: mediaViewModel.mediaList.length,
                itemBuilder: (context, index) {
                  MediaBase currentMedia = mediaViewModel.mediaList[index];

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

                  return const Center(
                    child: SizedBox.square(
                      dimension: 50,
                      child: Icon(Icons.warning),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
