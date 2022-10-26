import 'package:flutter_application_1/model/media_base_model.dart';

class MediaImage implements MediaBase<MediaImage> {
  num? aspectRatio;
  int? height;
  dynamic iso6391;
  String? filePath;
  num? voteAverage;
  int? voteCount;
  int? width;
  String? mediaType;

  MediaImage({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
    this.mediaType,
  });

  factory MediaImage.fromMap(Map<String, dynamic> json) => MediaImage(
        mediaType: 'image',
        aspectRatio: json["aspect_ratio"],
        height: json["height"],
        iso6391: json["iso_639_1"],
        filePath: json["file_path"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        width: json["width"],
      );

  Map<String, dynamic> toMap() => {
        "aspect_ratio": aspectRatio,
        "height": height,
        "iso_639_1": iso6391,
        "file_path": filePath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "width": width,
      };

  @override
  MediaImage fromMap(Map<String, dynamic> json) {
    return MediaImage.fromMap(json);
  }
}
