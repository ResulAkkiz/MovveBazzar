class Movier {
  final String movierID;
  final String movierEmail;
  final String movierUsername;
  final String? movierAge;
  final DateTime? movierBirthday;
  final String? movierGender;
  final String? movierPhotoUrl;
  final String? movierPhoneNumber;

  const Movier({
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
      movierEmail: map['movierEmail'],
      movierUsername: map['movierUsername'],
      movierAge: map['movierAge'] != null ? map['movierAge'] as String : null,
      movierBirthday: map['movierBirthday'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(map['movierBirthday'] * 1000)
          : null,
      movierGender: map['movierGender'],
      movierPhotoUrl: map['movierPhotoUrl'],
      movierPhoneNumber: map['movierPhoneNumber'],
    );
  }

  @override
  String toString() {
    return 'Movier(movierID: $movierID, movierEmail: $movierEmail, movierUsername: $movierUsername, movierAge: $movierAge, movierBirthday: $movierBirthday, movierPhotoUrl: $movierPhotoUrl, movierPhoneNumber: $movierPhoneNumber)';
  }
}
