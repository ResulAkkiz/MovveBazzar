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
    this.date,
    this.mediaName,
  });
  final String? mediaName;
  final bool? adult;
  final String? backdropPath;
  final int? id;
  final DateTime? date;
  final String? originalLanguage;
  final String? overview;
  final String? posterPath;
  final String? mediaType;
  final List<int>? genreIds;
  final double? popularity;
  final double? voteAverage;
  final int? voteCount;

  T fromMap(Map<String, dynamic> json);
}
