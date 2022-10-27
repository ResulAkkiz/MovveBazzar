import 'package:flutter_application_1/model/media_base_model.dart';

class MediaVideo implements MediaBase<MediaVideo> {
  const MediaVideo({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
    this.mediaType,
  });

  final String? mediaType;
  final String? iso6391;
  final String? iso31661;
  final String? name;
  final String? key;
  final String? site;
  final int? size;
  final String? type;
  final bool? official;
  final DateTime? publishedAt;
  final String? id;

  factory MediaVideo.fromMap(Map<String, dynamic> json) => MediaVideo(
        mediaType: 'video',
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: DateTime.tryParse(json["published_at"] ?? ''),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "site": site,
        "size": size,
        "type": type,
        "official": official,
        "published_at": publishedAt?.toIso8601String(),
        "id": id,
      };

  @override
  MediaVideo fromMap(Map<String, dynamic> json) {
    return MediaVideo.fromMap(json);
  }
}
