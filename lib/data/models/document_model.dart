import 'package:portal/commons/utils.dart';

class DocumentModel {
  String userId;
  String id;
  String url;
  DateTime date;
  String name;
  DocumentModel({
    required this.userId,
    required this.id,
    required this.url,
    required this.date,
    required this.name,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json, String documentId) {
    return DocumentModel(
        id: json['id'],
        userId: json['userId'],
        url: json['url'],
        date: convertTimeStampToDateTime(json['date']) ?? DateTime.now(),
        name: json['name']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'url': url,
      'date': date,
      'name': name,
    };
  }
}
