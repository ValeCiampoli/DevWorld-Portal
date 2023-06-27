import 'package:portal/data/models/appointement_model.dart';
  
abstract class AppointmentService {
  Future<void> setAppointment({required AppointmentModel appointment, bool merge = false});
  // Future<void> setSection(SectionModel section, String postId);
  Future<void> deleteAppointment({required AppointmentModel appointment});
  Future<List<AppointmentModel>> getAllForHome({bool? includePro, List<String>? doctorIds});
  // Future<List<PostModel>> getAllDraft({required String doctorId});
  // Future<List<PostModel>> getAllSaved({required String userId});
  //Future<List<AppointmentModel>> getAllPostByAndForMe({String? doctorId, String? userId, bool? isPrivate});
  Future<AppointmentModel> getByAppointmentId({required String postId});
  Future<List<AppointmentModel>> getAllAppointmentByAndForMe({required String userId});
  // Future<List<SectionModel>> getSectionsByPostId({required String postId});
  // Future<int> getUserPostCount({required String uid});
  // Future<PostModel> addLike({required String postId, required String userId});
  // Future<bool> reedemCode({required String userId, required String reedemCode});
  // Future<PostModel> removeLike({required String postId, required String userId});
  // Future<bool> clonePost({required PostModel appointment});
}