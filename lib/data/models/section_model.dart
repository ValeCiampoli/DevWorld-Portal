 import 'package:portal/data/models/section_media_model.dart';

class SectionModel {
  String sid;
  String title;
  int? position;
  List<SectionMediaModel>? sectionMediaList;

  SectionModel({
    required this.sid,
    required this.title,
    this.position,
    this.sectionMediaList,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json, String documentId) {
    return SectionModel(
      sid: documentId,
      title: json['title'],
      position: json['position'],
      sectionMediaList: json['sectionMediaList'] != null ? (json['sectionMediaList'] as List).map((item) => SectionMediaModel.fromJson(item)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'position': position,
      'sectionMediaList': sectionMediaList!.map((media) => media.toJson()).toList()
    };
  }

  factory SectionModel.fromShared(Map<String, dynamic> json) {
    return SectionModel(
      sid: json['sid'],
      title: json['title'],
      position: json['position'],
      sectionMediaList: json['sectionMediaList'] != null ? (json['sectionMediaList'] as List).map((item) => SectionMediaModel.fromJson(item)).toList() : null,
    );
  }

  Map<String, dynamic> toShared() {
    return {
      'sid': sid,
      'title': title,
      'position': position,
      'sectionMediaList': sectionMediaList!.map((media) => media.toJson()).toList()
    };
  }
}

