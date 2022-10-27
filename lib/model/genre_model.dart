class Genre {
  const Genre({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
