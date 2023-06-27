 
class UserModel {
  String uid;
  String name;
  String surname;
  String mail;
  bool isAdmin;
  String mansione;
  String fcmToken;
  List<String>? documents;

  UserModel({
    required this.uid,
    required this.name,
    required this.surname,
    required this.mail,
    required this.isAdmin,
    required this.mansione,
    required this.fcmToken,
    this.documents
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String userId) {
    return UserModel(
      uid: userId,
      name: json['name'],
      surname: json['surname'],
      mail: json['mail'],
      isAdmin: json['isAdmin'],
      mansione: json['mansione'],
      fcmToken: json['fcmToken'],
      documents: json['documents'] != null ? (json['documents'] as List).map((item) => item as String).toList() : null,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'mail': mail,
      'isAdmin': isAdmin,
      'mansione': mansione,
      'fcmToken': fcmToken,
      'documents':documents
    };
  }
}
