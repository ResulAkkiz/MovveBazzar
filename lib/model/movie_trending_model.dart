import 'package:flutter_application_1/model/base_trending_model.dart';

class MovieTrending extends IBaseTrendingModel<MovieTrending> {
  String? title;
  String? originalTitle;
  bool? video;
  DateTime? releaseDate;

  MovieTrending(
      {this.title,
      this.originalTitle,
      this.releaseDate,
      super.adult,
      super.backdropPath,
      super.id,
      super.originalLanguage,
      super.overview,
      super.posterPath,
      super.mediaType,
      super.genreIds,
      super.popularity,
      this.video,
      super.voteAverage,
      super.voteCount});

  factory MovieTrending.fromMap(Map<String, dynamic> json) => MovieTrending(
        title: json["title"],
        originalTitle: json["original_title"],
        video: json["video"],
        releaseDate: DateTime.parse(json["release_date"]),
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalLanguage: json["original_language"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: json["media_type"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"].toDouble(),
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  @override
  String toString() {
    return 'MovieTrending(title: $title, originalTitle: $originalTitle, video: $video, releaseDate: $releaseDate)';
  }

  @override
  MovieTrending fromMap(Map<String, dynamic> json) {
    return MovieTrending.fromMap(json);
  }
}
