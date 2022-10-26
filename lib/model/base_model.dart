import './base_import.dart';

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
