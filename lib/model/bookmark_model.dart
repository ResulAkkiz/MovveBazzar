class BookMark {
  String mediaType;
  int mediaID;
  String mediaName;
  num? mediaVote;
  String? imagePath;
  DateTime? date;
  int? runtime;
  BookMark({
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
      'runtime': runtime
    };
  }

  factory BookMark.fromMap(Map<String, dynamic> map) {
    return BookMark(
      runtime: map['runtime'],
      date: map['date'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(map['date'] * 1000)
          : null,
      mediaVote: map['mediaVote'] as num,
      mediaType: map['mediaType'] as String,
      mediaID: map['mediaID'] as int,
      mediaName: map['mediaName'] as String,
      imagePath: map['imagePath'] as String,
    );
  }

  @override
  String toString() {
    return 'BookMark(mediaType: $mediaType, mediaID: $mediaID, mediaName: $mediaName, mediaVote: $mediaVote, imagePath: $imagePath, date: $date, runtime: $runtime)';
  }
}
