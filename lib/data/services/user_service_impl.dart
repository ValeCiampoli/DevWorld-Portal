 import 'package:flutter/foundation.dart';
import 'package:portal/commons/firestore/firestore_path.dart';
import 'package:portal/commons/firestore/firestore_service.dart';
import 'package:portal/data/models/user_model.dart';
import 'package:portal/data/services/interfaces/user_service.dart';

class UserServiceImpl implements UserService{
  final FirestoreService? firestoreService;

  UserServiceImpl({@required this.firestoreService});

  // Create/Update
  @override
  Future<void> setUser({required UserModel user, bool merge = false}) async => await firestoreService!.set(
        path: FirestorePath.user(user.uid),
        data: user.toJson(),
        merge: merge
      );

  // Delete
  @override
  Future<void> deleteUser(UserModel user) async {
    await firestoreService!.deleteData(path: FirestorePath.user(user.uid));
  }

  // Get by userId
  @override
  Future<UserModel?> getByUserId({required String userId}) async =>
      await firestoreService!.documentSnapshot(
        path: FirestorePath.user(userId),
        builder: (data, documentId) => UserModel.fromJson(data, documentId),
      );

  // Get all
  @override
  Future<List<UserModel>> getAllUsers() async => 
      await firestoreService!.collectionSnapshot(
        path: FirestorePath.users(),
        builder: (data, documentId) => UserModel.fromJson(data, documentId),
      );


  // Get all doctor 
  @override
  Future<List<UserModel>> searchUsers() async =>     
      await firestoreService!.collectionSnapshot(
          path: FirestorePath.users(),
          builder: (data, documentId) => UserModel.fromJson(data, documentId),
          queryBuilder: (query) {
            var tempQuery = query.where("isDoctor", isEqualTo: true);
            return tempQuery;
          },
          sort: ((lhs, rhs) => lhs.name.compareTo(rhs.name))
          );
  
   @override
  Future<List<UserModel>> searchAllUser() async =>     
      await firestoreService!.collectionSnapshot(
          path: FirestorePath.users(),
          builder: (data, documentId) => UserModel.fromJson(data, documentId),
          sort: ((lhs, rhs) => lhs.name.compareTo(rhs.name))
          );
          
  @override
  Future<bool> checkByMail({required String email}) async {
    var result = await firestoreService!.collectionSnapshot(
          path: FirestorePath.users(),
          builder: (data, documentId) => UserModel.fromJson(data, documentId),
          queryBuilder: (query) {
            var tempQuery = query.where("mail", isEqualTo: email);
            return tempQuery;
          });
    if(result.isEmpty){
      return false;
    }else{
      return true;
    }
  }
  
 
 
  
  @override
  Future<UserModel> updateEmail({required String userId, required String newMail}) async {
    var currentUser = await getByUserId(userId: userId);
    currentUser!.mail = newMail;
    await setUser(user: currentUser, merge: true);
    
    return currentUser;
  }
  
 
   
}