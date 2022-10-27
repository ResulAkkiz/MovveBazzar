// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application_1/model/base_trending_model.dart';

class PeopleTrending extends IBaseTrendingModel<PeopleTrending> {
  String? name;
  String? originalName;
  int? gender;
  String? knownForDepartment;
  String? profilePath;
  dynamic knownFor;
  PeopleTrending({
    this.name,
    this.originalName,
    this.gender,
    this.knownForDepartment,
    this.profilePath,
    this.knownFor,
    super.adult,
    super.id,
    super.mediaType,
    super.popularity,
    super.voteAverage,
    super.voteCount,
    super.mediaName,
  });

  factory PeopleTrending.fromMap(Map<String, dynamic> json) => PeopleTrending(
        mediaName: json["name"],
        adult: json['adult'],
        id: json['id'],
        name: json['name'],
        originalName: json['original_name'],
        mediaType: json['media_type'],
        popularity: json['popularity'],
        gender: json['gender'],
        knownForDepartment: json['known_for_department'],
        profilePath: json['profile_path'],
        knownFor: json['known_for'],
      );
  @override
  PeopleTrending fromMap(Map<String, dynamic> json) {
    return PeopleTrending.fromMap(json);
  }
}
