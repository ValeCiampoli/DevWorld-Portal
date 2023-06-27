import 'package:portal/commons/utils.dart';
import 'package:portal/data/models/section_model.dart';

class PostModel {
  String pid;
  String doctorId;
  String mainTitle;
  String? mainImage;
  String? reedemableCode;
  bool isFromPro;
  bool isPublished;
  DateTime date;
  List<SectionModel>? section;
  List<String>? tags;
  bool isPrivate;
  String? destinationUid;
  List<String>? userIdLikes;

  PostModel({
    required this.pid,
    required this.doctorId,
    required this.mainTitle,
    this.mainImage,
    this.reedemableCode,
    required this.isFromPro,
    required this.isPublished,
    required this.date,
    this.section,
    this.tags,
    required this.isPrivate,
    this.destinationUid,
    this.userIdLikes,
  });

  factory PostModel.fromJson(Map<String, dynamic> json, String documentId) {
    return PostModel(
      pid: documentId,
      doctorId: json['doctorId'],
      mainTitle: json['mainTitle'],
      mainImage: json['mainImage'],
      isFromPro: json['isFromPro'],
      reedemableCode: json['reedemableCode'],
      isPublished: json['isPublished'],
      date: convertTimeStampToDateTime(json['date']) ?? DateTime.now(),
      //section: json['section'],
      tags: json['tags'] != null ? (json['tags'] as List).map((item) => item as String).toList() : null,
      isPrivate: json['isPrivate'],
      destinationUid: json['destinationUid'],
      userIdLikes: json['userIdLikes'] != null ? (json['userIdLikes'] as List).map((item) => item as String).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'mainTitle': mainTitle,
      'mainImage': mainImage,
      'isFromPro': isFromPro,
      'isPublished': isPublished,
      'reedemableCode': reedemableCode,
      'date': date,
      //'section': section,
      'tags': tags,
      'isPrivate': isPrivate,
      'destinationUid': destinationUid,
      'userIdLikes': userIdLikes,
    };
  }                
}
