class CastCredit {
  CastCredit({
    required this.id,
    this.overview,
    this.name,
    this.mediaType,
    this.posterPath,
    this.date,
    this.voteAverage,
    this.voteCount,
    this.character,
    this.backdropPath,
    this.creditId,
  });

  int id;
  String? overview;
  String? name;
  String? mediaType;
  String? posterPath;
  DateTime? date;
  double? voteAverage;
  int? voteCount;
  String? character;
  String? backdropPath;
  String? creditId;

  factory CastCredit.fromMap(Map<String, dynamic> json) => CastCredit(
        id: json["id"],
        overview: json["overview"],
        name: json["name"] ?? json["title"],
        mediaType: json["media_type"],
        posterPath: json["poster_path"],
        date: json["first_air_date"] != null
            ? DateTime.tryParse(json["first_air_date"])
            : DateTime.tryParse(json["release_date"]),
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        character: json["character"],
        backdropPath: json["backdrop_path"],
        creditId: json["credit_id"],
      );
}
