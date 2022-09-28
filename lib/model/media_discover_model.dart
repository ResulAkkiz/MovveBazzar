import 'package:flutter_application_1/model/base_trending_model.dart';

class MovieDiscover extends IBaseTrendingModel<MovieDiscover> {
  String? title; //name
  String? originalTitle; //originalname
  bool? video;
  DateTime? releaseDate;

  MovieDiscover(
      {this.title,
      this.originalTitle,
      this.releaseDate,
      super.adult,
      super.backdropPath,
      super.id,
      super.originalLanguage,
      super.overview,
      super.date,
      super.posterPath,
      super.mediaType,
      super.genreIds,
      super.popularity,
      super.mediaName,
      this.video,
      super.voteAverage,
      super.voteCount});

  factory MovieDiscover.fromMap(Map<String, dynamic> json) => MovieDiscover(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        date: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  @override
  MovieDiscover fromMap(Map<String, dynamic> json) {
    return MovieDiscover.fromMap(json);
  }
}
