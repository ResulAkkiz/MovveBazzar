abstract class IBaseTrendingModel<T> {
  IBaseTrendingModel({
    this.adult,
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.genreIds,
    this.popularity,
    this.voteAverage,
    this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final int? id;
  final String? originalLanguage;
  final String? overview;
  final String? posterPath;
  final String? mediaType;
  final List<int>? genreIds;
  final double? popularity;
  final double? voteAverage;
  final int? voteCount;

  T fromMap(Map<String, dynamic> json);

  /*Map<String, dynamic> toMap() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "original_language": originalLanguage,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };*/
}
