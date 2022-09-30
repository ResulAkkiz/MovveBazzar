class People {
  People({
    this.birthday,
    this.knownForDepartment,
    this.deathday,
    this.id,
    this.name,
    this.alsoKnownAs,
    this.gender,
    this.biography,
    this.popularity,
    this.placeOfBirth,
    this.profilePath,
    this.adult,
    this.imdbId,
    this.homepage,
  });

  DateTime? birthday;
  String? knownForDepartment;
  String? deathday;
  int? id;
  String? name;
  List<String>? alsoKnownAs;
  int? gender;
  String? biography;
  double? popularity;
  String? placeOfBirth;
  String? profilePath;
  bool? adult;
  String? imdbId;
  dynamic homepage;

  factory People.fromMap(Map<String, dynamic> json) => People(
        birthday: json["birthday"] != null
            ? DateTime.parse(json["birthday"] ?? DateTime.now())
            : null,
        knownForDepartment: json["known_for_department"],
        deathday: json["deathday"],
        id: json["id"],
        name: json["name"],
        alsoKnownAs: json["also_known_as"] != null
            ? List<String>.from(json["also_known_as"].map((x) => x))
            : null,
        gender: json["gender"],
        biography: json["biography"],
        popularity: json["popularity"].toDouble(),
        placeOfBirth: json["place_of_birth"],
        profilePath: json["profile_path"],
        adult: json["adult"],
        imdbId: json["imdb_id"],
        homepage: json["homepage"],
      );

  Map<String, dynamic> toMap() => {
        "birthday":
            "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
        "known_for_department": knownForDepartment,
        "deathday": deathday,
        "id": id,
        "name": name,
        "also_known_as": List<dynamic>.from(alsoKnownAs!.map((x) => x)),
        "gender": gender,
        "biography": biography,
        "popularity": popularity,
        "place_of_birth": placeOfBirth,
        "profile_path": profilePath,
        "adult": adult,
        "imdb_id": imdbId,
        "homepage": homepage,
      };
}
