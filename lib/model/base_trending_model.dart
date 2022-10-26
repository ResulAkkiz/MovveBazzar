abstract class IBaseTrendingModel<T> {
  IBaseTrendingModel({
    this.adult,
    this.id,
    this.mediaType,
    this.popularity,
    this.voteAverage,
    this.voteCount,
    this.mediaName,
  });
  final String? mediaName;
  final bool? adult;
  final int? id;
  final String? mediaType;
  final num? popularity;
  final num? voteAverage;
  final int? voteCount;

  T fromMap(Map<String, dynamic> json);
}
