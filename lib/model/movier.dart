// ignore_for_file: public_member_api_docs, sort_constructors_first
class Movier {
  String movierID;
  String movierEmail;
  String movierUsername;
  String? movierAge;
  DateTime? movierBirthday;
  String? movierPhotoUrl;
  String? movierPhoneNumber;

  Movier({
    required this.movierID,
    required this.movierEmail,
    required this.movierUsername,
    this.movierAge,
    this.movierBirthday,
    this.movierPhotoUrl,
    this.movierPhoneNumber,
  });
}
