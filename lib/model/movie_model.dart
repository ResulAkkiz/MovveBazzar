import 'package:flutter_application_1/model/base_model.dart';

import './base_import.dart';

class Movie extends IBaseModel<Movie> {
  const Movie({
    required super.id,
    super.overview,
    super.popularity,
    super.posterPath,
    super.genres,
    super.adult,
    super.backdropPath,
    super.homepage,
    super.originalLanguage,
    super.spokenLanguages,
    super.productionCompanies,
    super.productionCountries,
    super.voteAverage,
    super.voteCount,
    super.tagline,
    super.status,
    this.belongsToCollection,
    this.budget,
    this.imdbId,
    this.originalTitle,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.title,
    this.video,
  });

  final dynamic belongsToCollection;
  final int? budget;
  final String? imdbId;
  final String? originalTitle;
  final DateTime? releaseDate;
  final int? revenue;
  final int? runtime;
  final String? title;
  final bool? video;

  @override
  Movie fromMap(Map<String, dynamic> json) => Movie.fromMap(json);

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        id: json["id"],
        overview: json["overview"],
        popularity: json["popularity"],
        posterPath: json["poster_path"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        homepage: json["homepage"],
        originalLanguage: json["original_language"],
        spokenLanguages: List<SpokenLanguage>.from(
            json["spoken_languages"].map((x) => SpokenLanguage.fromMap(x))),
        productionCompanies: List<ProductionCompany>.from(
            json["production_companies"]
                .map((x) => ProductionCompany.fromMap(x))),
        productionCountries: List<ProductionCountry>.from(
            json["production_countries"]
                .map((x) => ProductionCountry.fromMap(x))),
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        tagline: json["tagline"],
        status: json["status"],
        belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"],
        imdbId: json["imdb_id"],
        originalTitle: json["original_title"],
        releaseDate: DateTime.tryParse(json["release_date"] ?? ''),
        revenue: json["revenue"],
        runtime: json["runtime"],
        title: json["title"],
        video: json["video"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "genres": List<dynamic>.from(genres!.map((x) => x.toMap())),
        "adult": adult,
        "backdrop_path": backdropPath,
        "homepage": homepage,
        "original_language": originalLanguage,
        "spoken_languages":
            List<dynamic>.from(spokenLanguages!.map((x) => x.toMap())),
        "production_companies":
            List<dynamic>.from(productionCompanies!.map((x) => x.toMap())),
        "production_countries":
            List<dynamic>.from(productionCountries!.map((x) => x.toMap())),
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "tagline": tagline,
        "status": status,
        "belongs_to_collection": belongsToCollection,
        "budget": budget,
        "imdb_id": imdbId,
        "original_title": originalTitle,
        "release_date": releaseDate,
        "revenue": revenue,
        "runtime": runtime,
        "title": title,
        "video": video,
      };
}
