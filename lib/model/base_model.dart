import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/model/type_definitions.dart';

import './base_import.dart';

abstract class IBaseModel<T> extends Equatable {
  const IBaseModel({
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

  final Id id;
  final String? overview;
  final num? popularity;
  final String? posterPath;
  final List<Genre>? genres;
  final bool? adult;
  final String? backdropPath;
  final String? homepage;
  final String? originalLanguage;
  final List<SpokenLanguage>? spokenLanguages;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final num? voteAverage;
  final int? voteCount;
  final String? tagline;
  final String? status;

  @override
  List<Object> get props => [id];

  T fromMap(Map<String, dynamic> json);
}
