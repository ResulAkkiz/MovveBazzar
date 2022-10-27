// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application_1/model/base_trending_model.dart';

class TrendingPeople extends IBaseTrendingModel<TrendingPeople> {
  final String? name;
  final String? originalName;
  final int? gender;
  final String? knownForDepartment;
  final String? profilePath;
  final dynamic knownFor;

  const TrendingPeople({
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

  factory TrendingPeople.fromMap(Map<String, dynamic> json) => TrendingPeople(
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
  TrendingPeople fromMap(Map<String, dynamic> json) {
    return TrendingPeople.fromMap(json);
  }
}
