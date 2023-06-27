class MemoModel {
  double top;
  double left;
  String userId;
  String id;
  String body;
  MemoModel({
    required this.top,
    required this.left,
    required this.userId,
    required this.id,
    required this.body,
  });

  factory MemoModel.fromJson(Map<String, dynamic> json, String documentId) {
    return MemoModel(
        id: json['id'], userId: json['userId'], body: json['body'], left: json['left'], top: json['top']);
  }
  Map<String, dynamic> toJson() {
    return {
      'top': top,
      'left':left,
      'id': id,
      'userId': userId,
      'body': body,
    };
  }
}
