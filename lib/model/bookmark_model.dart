import 'package:flutter_application_1/model/type_definitions.dart';

class BookMark {
  final String mediaType;
  final Id mediaID;
  final String mediaName;
  final num? mediaVote;
  final String? imagePath;
  final DateTime? date;
  final int? runtime;

  const BookMark({
    required this.date,
    required this.mediaVote,
    required this.mediaType,
    required this.mediaID,
    required this.mediaName,
    required this.imagePath,
    required this.runtime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mediaVote': mediaVote,
      'mediaType': mediaType,
      'mediaID': mediaID,
      'mediaName': mediaName,
      'imagePath': imagePath,
      'date': date?.millisecondsSinceEpoch,
      'runtime': runtime,
    };
  }

  factory BookMark.fromMap(Map<String, dynamic> map) {
    return BookMark(
      runtime: map['runtime'],
      date: map['date'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(map['date'] * 1000)
          : null,
      mediaVote: map['mediaVote'],
      mediaType: map['mediaType'],
      mediaID: map['mediaID'],
      mediaName: map['mediaName'],
      imagePath: map['imagePath'],
    );
  }

  @override
  String toString() {
    return 'BookMark(mediaType: $mediaType, mediaID: $mediaID, mediaName: $mediaName, mediaVote: $mediaVote, imagePath: $imagePath, date: $date, runtime: $runtime)';
  }
}
