// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/base_trending_show_model.dart';

class MovieTrending extends IBaseTrendingShowModel<MovieTrending> {
  String? title; //name
  String? originalTitle; //originalname
  bool? video;

  DateTime? releaseDate; //fi

  MovieTrending({
    this.title,
    this.originalTitle,
    this.video,
    super.backdropPath,
    this.releaseDate,
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
