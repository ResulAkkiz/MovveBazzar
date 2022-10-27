import 'package:flutter_application_1/model/base_model.dart';

import './base_import.dart';

class Tv extends IBaseModel<Tv> {
  const Tv({
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
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalName,
    this.seasons,
    this.type,
  });

  final List<CreatedBy>? createdBy;
  final List<int?>? episodeRunTime;
  final DateTime? firstAirDate;
  final bool? inProduction;
  final List<String?>? languages;
  final DateTime? lastAirDate;
  final LastEpisodeToAir? lastEpisodeToAir;
  final String? name;
  final dynamic nextEpisodeToAir;
  final List<Network>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String?>? originCountry;
  final String? originalName;
  final List<Season>? seasons;
  final String? type;

  @override
  Tv fromMap(Map<String, dynamic> json) => Tv.fromMap(json);

  factory Tv.fromMap(Map<String, dynamic> json) => Tv(
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
        createdBy: List<CreatedBy>.from(
            json["created_by"].map((x) => CreatedBy.fromMap(x))),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: DateTime.tryParse(json["first_air_date"] ?? ''),
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.tryParse(json["last_air_date"] ?? ''),
        lastEpisodeToAir: LastEpisodeToAir.fromMap(json["last_episode_to_air"]),
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
        networks:
            List<Network>.from(json["networks"].map((x) => Network.fromMap(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalName: json["original_name"],
        seasons:
            List<Season>.from(json["seasons"].map((x) => Season.fromMap(x))),
        type: json["type"],
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
        "created_by": createdBy,
        "episode_run_time": episodeRunTime,
        "first_air_date": firstAirDate,
        "in_production": inProduction,
        "languages": languages,
        "last_air_date": lastAirDate,
        "last_episode_to_air": lastEpisodeToAir?.toMap(),
        "name": name,
        "next_episode_to_air": nextEpisodeToAir,
        "networks": networks,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": originCountry,
        "original_name": originalName,
        "seasons": List<dynamic>.from(seasons!.map((x) => x.toMap())),
        "type": type,
      };
}

class CreatedBy {
  const CreatedBy({
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });

  final int? id;
  final String? creditId;
  final String? name;
  final int? gender;
  final String? profilePath;

  factory CreatedBy.fromMap(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        gender: json["gender"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "gender": gender,
        "profile_path": profilePath,
      };
}

class LastEpisodeToAir {
  const LastEpisodeToAir({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  final DateTime? airDate;
  final int? episodeNumber;
  final int? id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final int? showId;
  final String? stillPath;
  final num? voteAverage;
  final int? voteCount;

  factory LastEpisodeToAir.fromMap(Map<String, dynamic> json) =>
      LastEpisodeToAir(
        airDate: DateTime.tryParse(json["air_date"] ?? ''),
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toMap() => {
        "air_date": airDate,
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class Network {
  const Network({
    this.id,
    this.name,
    this.logoPath,
    this.originCountry,
  });

  final int? id;
  final String? name;
  final String? logoPath;
  final String? originCountry;

  factory Network.fromMap(Map<String, dynamic> json) => Network(
        id: json["id"],
        name: json["name"],
        logoPath: json["logo_path"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "logo_path": logoPath,
        "origin_country": originCountry,
      };
}

class Season {
  const Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });

  final DateTime? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;

  factory Season.fromMap(Map<String, dynamic> json) {
    return Season(
      airDate: DateTime.tryParse(json["air_date"] ?? ''),
      episodeCount: json["episode_count"],
      id: json["id"],
      name: json["name"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      seasonNumber: json["season_number"],
    );
  }

  Map<String, dynamic> toMap() => {
        "air_date": airDate,
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };
}
