import 'package:flutter_application_1/model/base_trending_model.dart';

abstract class IBaseTrendingShowModel<T> extends IBaseTrendingModel<T> {
  final String? backdropPath;
  final DateTime? date;
  final String? originalLanguage;
  final String? overview;
  final String? posterPath;
  final List<int?>? genreIds;

  const IBaseTrendingShowModel({
    this.genreIds,
    this.date,
    this.overview,
    this.backdropPath,
    this.originalLanguage,
    this.posterPath,
    super.id,
    super.adult,
    super.mediaType,
    super.popularity,
    super.voteAverage,
    super.voteCount,
    super.mediaName,
  });
}
