import 'package:flutter_application_1/model/type_definitions.dart';

abstract class IBaseTrendingModel<T> {
  const IBaseTrendingModel({
    this.id,
    this.adult,
    this.mediaType,
    this.popularity,
    this.voteAverage,
    this.voteCount,
    this.mediaName,
  });

  final Id? id;
  final String? mediaName;
  final bool? adult;
  final String? mediaType;
  final num? popularity;
  final num? voteAverage;
  final int? voteCount;

  T fromMap(Map<String, dynamic> json);
}
