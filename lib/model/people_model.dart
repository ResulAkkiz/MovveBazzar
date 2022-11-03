import 'package:flutter_application_1/model/base_model.dart';
import 'package:flutter_application_1/model/castcredit_model.dart';

class Person extends IBaseModel<Person> {
  Person({
    this.birthday,
    this.deathday,
    this.gender,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.profilePath,
    this.combinedCredits,
    required super.id,
    super.overview,
    super.popularity,
    super.posterPath,
    super.adult,
    super.homepage,
  });

  String? biography;
  DateTime? birthday;
  DateTime? deathday;
  int? gender;

  String? imdbId;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;

  String? profilePath;
  Credits? combinedCredits;

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        adult: json["adult"],
        overview: json["biography"],
        birthday: DateTime.tryParse(json["birthday"] ?? ''),
        deathday: DateTime.tryParse(json["deathday"] ?? ''),
        gender: json["gender"],
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        placeOfBirth: json["place_of_birth"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
        combinedCredits: Credits.fromMap(json["combined_credits"]),
      );

  @override
  Person fromMap(Map<String, dynamic> json) {
    return Person.fromMap(json);
  }
}

class Credits {
  Credits({
    this.cast,
    this.crew,
  });

  List<Cast>? cast;
  List<Cast>? crew;

  factory Credits.fromMap(Map<String, dynamic> json) => Credits(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
      );
}
