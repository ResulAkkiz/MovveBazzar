import 'package:flutter_application_1/model/base_model.dart';

class Person extends IBaseModel<Person> {
  Person({
    this.birthday,
    this.knownForDepartment,
    this.deathday,
    this.name,
    this.gender,
    this.placeOfBirth,
    this.imdbId,
    required super.id,
    super.overview,
    super.popularity,
    super.posterPath,
    super.adult,
    super.homepage,
  });

  DateTime? birthday;
  String? knownForDepartment;
  DateTime? deathday;
  String? name;
  int? gender;
  String? placeOfBirth;
  String? imdbId;

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        birthday: DateTime.tryParse(json["birthday"] ?? ''),
        knownForDepartment: json["known_for_department"],
        deathday: DateTime.tryParse(json["deathday"] ?? ''),
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        overview: json["biography"],
        popularity: json["popularity"],
        placeOfBirth: json["place_of_birth"],
        posterPath: json["profile_path"],
        adult: json["adult"],
        imdbId: json["imdb_id"],
        homepage: json["homepage"],
      );

  @override
  Person fromMap(Map<String, dynamic> json) {
    return Person.fromMap(json);
  }
}
