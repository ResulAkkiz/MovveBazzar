class Movier {
  String movierID;
  String movierEmail;
  String movierUsername;
  String? movierAge;
  DateTime? movierBirthday;
  String? movierGender;
  String? movierPhotoUrl;
  String? movierPhoneNumber;

  Movier({
    required this.movierID,
    required this.movierEmail,
    required this.movierUsername,
    this.movierAge,
    this.movierBirthday,
    this.movierGender,
    this.movierPhotoUrl,
    this.movierPhoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'movierID': movierID,
      'movierEmail': movierEmail,
      'movierUsername': movierUsername,
      'movierAge': movierAge,
      'movierBirthday': movierBirthday?.millisecondsSinceEpoch,
      'movierPhotoUrl': movierPhotoUrl,
      'movierGender': movierGender,
      'movierPhoneNumber': movierPhoneNumber,
    };
  }

  factory Movier.fromMap(Map<String, dynamic> map) {
    return Movier(
      movierID: map['movierID'] as String,
      movierEmail: map['movierEmail'] as String,
      movierUsername: map['movierUsername'] as String,
      movierAge: map['movierAge'] != null ? map['movierAge'] as String : null,
      movierBirthday: map['movierBirthday'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(map['movierBirthday'] * 1000)
          : null,
      movierGender: map['movierGender'],
      movierPhotoUrl: map['movierPhotoUrl'] != null
          ? map['movierPhotoUrl'] as String
          : null,
      movierPhoneNumber: map['movierPhoneNumber'] != null
          ? map['movierPhoneNumber'] as String
          : null,
    );
  }

  @override
  String toString() {
    return 'Movier(movierID: $movierID, movierEmail: $movierEmail, movierUsername: $movierUsername, movierAge: $movierAge, movierBirthday: $movierBirthday, movierPhotoUrl: $movierPhotoUrl, movierPhoneNumber: $movierPhoneNumber)';
  }
}
