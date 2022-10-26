class Review {
  Review({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
  });

  String? author;
  AuthorDetails? authorDetails;
  String? content;
  DateTime? createdAt;
  String? id;

  factory Review.fromMap(Map<String, dynamic> json) => Review(
        author: json["author"],
        authorDetails: AuthorDetails.fromMap(json["author_details"]),
        content: json["content"],
        createdAt: DateTime.tryParse(json["created_at"] ?? ''),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "author": author,
        "author_details": authorDetails!.toMap(),
        "content": content,
        "created_at": createdAt!.toIso8601String(),
        "id": id,
      };
}

class AuthorDetails {
  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
  });

  String? name;
  String? username;
  String? avatarPath;

  factory AuthorDetails.fromMap(Map<String, dynamic> json) => AuthorDetails(
        name: json["name"],
        username: json["username"],
        avatarPath: json["avatar_path"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "username": username,
        "avatar_path": avatarPath,
      };
}
