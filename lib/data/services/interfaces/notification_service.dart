import 'package:portal/data/models/notification_model.dart';

abstract class NotificationService {
  Future<void> setNotification({required NotificationModel notification, bool merge = false});
  Future<void> deleteNotification(NotificationModel notification);
  Future<NotificationModel> getByNotificationId({required String notificationId});
  Future<List<NotificationModel>> getAllNotificationByMe({required String userId});
  Future<List<NotificationModel>> getAllNotificationToMe({required String userId});
  Future<NotificationModel> updateNotification({required String nid});
}