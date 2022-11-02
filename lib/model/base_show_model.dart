// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application_1/model/base_model.dart';

import './base_import.dart';

abstract class IBaseShowModel<T> extends IBaseModel<T> {
  List<Genre>? genres;
  String? backdropPath;
  String? originalLanguage;
  List<SpokenLanguage>? spokenLanguages;
  List<ProductionCompany>? productionCompanies;
  List<ProductionCountry>? productionCountries;
  num? voteAverage;
  int? voteCount;
  String? tagline;
  String? status;

  IBaseShowModel({
    this.genres,
    this.backdropPath,
    this.originalLanguage,
    this.spokenLanguages,
    this.productionCompanies,
    this.productionCountries,
    this.voteAverage,
    this.voteCount,
    this.tagline,
    this.status,
    required super.id,
    super.overview,
    super.popularity,
    super.posterPath,
    super.adult,
    super.homepage,
  });
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
