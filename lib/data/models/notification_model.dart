import 'package:portal/commons/utils.dart';

class NotificationModel {
  String nid;
  String fromUid;
  String fromFullName;
  String fromImage;
  bool fromCertificate;
  String toUid;
  String? title;
  String? body;
  DateTime date;
  bool isOpened;

  NotificationModel({
    required this.nid,
    required this.fromUid,
    required this.fromFullName,
    required this.fromImage,
    required this.fromCertificate,
    required this.toUid,
    this.title,
    this.body,
    required this.date,
    required this.isOpened,
  });

   factory NotificationModel.fromJson(Map<String, dynamic> json, String documentId) {
    return NotificationModel(
      nid: documentId,
      fromUid: json['fromUid'],
      fromFullName: json['fromFullName'],
      fromImage: json['fromImage'],
      fromCertificate: json['fromCertificate'],
      toUid: json['toUid'],
      title: json['title'],
      body: json['body'],
      date: convertTimeStampToDateTime(json['date']) ?? DateTime.now(),
      isOpened: json['isOpened'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromUid': fromUid,
      'fromFullName': fromFullName,
      'fromImage': fromImage,
      'fromCertificate': fromCertificate,
      'toUid': toUid,
      'title': title,
      'body': body,
      'date': date,
      'isOpened': isOpened,
    };
  }   

}