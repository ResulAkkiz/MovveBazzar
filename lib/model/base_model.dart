abstract class IBaseModel<T> {
  IBaseModel({
    required this.id,
    this.overview,
    this.popularity,
    this.posterPath,
    this.genres,
    this.adult,
    this.backdropPath,
    this.homepage,
    this.originalLanguage,
    this.spokenLanguages,
    this.productionCompanies,
    this.productionCountries,
    this.voteAverage,
    this.voteCount,
    this.tagline,
    this.status,
  });

  int id;
  String? overview;
  num? popularity;
  String? posterPath;
  List<Genre>? genres;
  bool? adult;
  String? backdropPath;
  String? homepage;
  String? originalLanguage;
  List<SpokenLanguage>? spokenLanguages;
  List<ProductionCompany>? productionCompanies;
  List<ProductionCountry>? productionCountries;
  num? voteAverage;
  int? voteCount;
  String? tagline;
  String? status;

  T fromMap(Map<String, dynamic> json);
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class ProductionCompany {
  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  factory ProductionCompany.fromMap(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}

class ProductionCountry {
  ProductionCountry({
    this.iso31661,
    this.name,
  });

  String? iso31661;
  String? name;

  factory ProductionCountry.fromMap(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "iso_3166_1": iso31661,
        "name": name,
      };
}

class SpokenLanguage {
  SpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });

  String? englishName;
  String? iso6391;
  String? name;

  factory SpokenLanguage.fromMap(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
      };
}
