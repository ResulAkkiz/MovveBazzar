import 'package:flutter_application_1/model/base_trending_model.dart';

class MovieTrending extends IBaseTrendingModel<MovieTrending> {
  String? title; //name
  String? originalTitle; //originalname
  bool? video;
  DateTime? releaseDate; //fi

  MovieTrending(
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

  factory MovieTrending.fromMap(Map<String, dynamic> json) => MovieTrending(
        mediaName: json["title"],
        title: json["title"],
        originalTitle: json["original_title"],
        video: json["video"],
        date: DateTime.tryParse(json["release_date"] ?? ''),
        releaseDate: DateTime.tryParse(json["release_date"] ?? ''),
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalLanguage: json["original_language"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: json["media_type"] ?? 'movie',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"],
        voteAverage: json["vote_average"],
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
