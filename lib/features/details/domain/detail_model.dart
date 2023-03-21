class Detail {
  final int? id;
  final String recordType;
  final String recordCode;
  final String recordTitle;
  final String reportedBy;
  final String reportedDate;
  final String dateOccurred;
  final String? image;
  Detail(
      {this.id,
      required this.recordType,
      required this.recordCode,
      required this.recordTitle,
      required this.reportedBy,
      required this.reportedDate,
      required this.dateOccurred,
      this.image});

  factory Detail.fromMap(Map<String, dynamic> parseJSON) => Detail(
        id: parseJSON['id'],
        recordType: parseJSON['recordType'],
        recordCode: parseJSON['recordCode'],
        recordTitle: parseJSON['recordTitle'],
        reportedBy: parseJSON['reportedBy'],
        reportedDate: parseJSON['reportedDate'],
        dateOccurred: parseJSON['dateOccurred'],
        image: parseJSON['image'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recordType': recordType,
      'recordCode': recordCode,
      'recordTitle': recordTitle,
      'reportedBy': reportedBy,
      'reportedDate': reportedDate,
      'dateOccurred': dateOccurred,
      'image': image,
    };
  }
}
