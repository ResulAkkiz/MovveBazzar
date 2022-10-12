import 'package:flutter_application_1/model/base_trending_model.dart';

class TvTrending extends IBaseTrendingModel<TvTrending> {
  String? name;
  String? originalName;
  DateTime? firstAirDate;
  List<String>? originCountry;

  TvTrending(
      {this.name,
      this.originalName,
      this.originCountry,
      this.firstAirDate,
      super.adult,
      super.backdropPath,
      super.id,
      super.date,
      super.originalLanguage,
      super.overview,
      super.posterPath,
      super.mediaType,
      super.genreIds,
      super.popularity,
      super.voteAverage,
      super.mediaName,
      super.voteCount});

  factory TvTrending.fromMap(Map<String, dynamic> json) => TvTrending(
        mediaName: json["name"],
        name: json["name"],
        originalName: json["original_name"],
        date: DateTime.parse(json["first_air_date"]),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        originCountry: json["originCountry"],
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalLanguage: json["original_language"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: json["media_type"] ?? 'tv',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"].toDouble(),
        voteAverage: json["vote_average"].toDouble(),
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
