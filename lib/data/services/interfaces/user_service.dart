import 'package:portal/data/models/user_model.dart';

abstract class UserService {
  Future<void> setUser({required UserModel user, bool merge = false});
  Future<void> deleteUser(UserModel user);
   Future<UserModel?> getByUserId({required String userId});
  Future<bool> checkByMail({required String email});
  Future<List<UserModel>> getAllUsers();
  Future<List<UserModel>> searchUsers();
  Future<List<UserModel>> searchAllUser();
  Future<UserModel> updateEmail({required String userId, required String newMail});
}