abstract class IBaseModel<T> {
  int id;
  String? overview;
  num? popularity;
  String? posterPath;
  bool? adult;
  String? homepage;
  IBaseModel({
    required this.id,
    this.overview,
    this.popularity,
    this.posterPath,
    this.adult,
    this.homepage,
  });

  T fromMap(Map<String, dynamic> json);
}
