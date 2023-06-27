import 'package:portal/commons/enum.dart';

class SectionMediaModel {
  InputCreateType mediaType;
  String mediaContent;
  String? mediaName;

  SectionMediaModel({
    required this.mediaType,
    required this.mediaContent,
    this.mediaName,
  });

  factory SectionMediaModel.fromJson(Map<String, dynamic> json) {
    return SectionMediaModel(
      mediaType: InputCreateType.values.byName(json['mediaType']),
      mediaContent: json['mediaContent'],
      mediaName: json['mediaName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mediaType': mediaType.name,
      'mediaContent': mediaContent,
      'mediaName': mediaName
    };
  }
}
