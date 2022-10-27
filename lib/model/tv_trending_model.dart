// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application_1/model/base_trending_show_model.dart';

class TvTrending extends IBaseTrendingShowModel<TvTrending> {
  final String? name;
  final String? originalName;
  final DateTime? firstAirDate;
  final List<String?>? originCountry;

  const TvTrending({
    this.name,
    this.originalName,
    this.firstAirDate,
    super.backdropPath,
    this.originCountry,
    super.originalLanguage,
    super.overview,
    super.date,
    super.posterPath,
    super.genreIds,
    super.adult,
    super.id,
    super.mediaType,
    super.popularity,
    super.voteAverage,
    super.voteCount,
    super.mediaName,
  });

  factory TvTrending.fromMap(Map<String, dynamic> json) => TvTrending(
        mediaName: json["name"],
        name: json["name"],
        originalName: json["original_name"],
        date: DateTime.tryParse(json["first_air_date"] ?? ''),
        firstAirDate: DateTime.tryParse(json["first_air_date"] ?? ''),
        originCountry: json["originCountry"],
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalLanguage: json["original_language"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: json["media_type"] ?? 'tv',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  @override
  String toString() {
    return 'TvTrending(name: $name, originalName: $originalName, firstAirDate: $firstAirDate, originCountry: $originCountry)';
  }

  @override
  TvTrending fromMap(Map<String, dynamic> json) {
    return TvTrending.fromMap(json);
  }
}
