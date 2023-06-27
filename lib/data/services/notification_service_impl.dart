import 'package:flutter/foundation.dart';
import 'package:portal/commons/firestore/firestore_path.dart';
import 'package:portal/commons/firestore/firestore_service.dart';
import 'package:portal/data/models/notification_model.dart';
import 'package:portal/data/services/interfaces/notification_service.dart';

class NotificationServiceImpl implements NotificationService{
  final FirestoreService? firestoreService;

  NotificationServiceImpl({@required this.firestoreService});

  // Create/Update
  @override
  Future<void> setNotification({required NotificationModel notification, bool merge = false}) async => await firestoreService!.set(
        path: FirestorePath.notification(notification.nid),
        data: notification.toJson(),
        merge: merge
      );

  // Delete
  @override
  Future<void> deleteNotification(NotificationModel notification) async {
    await firestoreService!.deleteData(path: FirestorePath.notification(notification.nid));
  }

  // Get by notificationId
  @override
  Future<NotificationModel> getByNotificationId({required String notificationId}) async =>
      await firestoreService!.documentSnapshot(
        path: FirestorePath.notification(notificationId),
        builder: (data, documentId) => NotificationModel.fromJson(data, documentId),
      );

  // Get all notification by current user
  @override
  Future<List<NotificationModel>> getAllNotificationByMe({required String userId}) async{
    return await firestoreService!.collectionSnapshot(
      path: FirestorePath.notifications(), 
      builder: ((data, documentID) => NotificationModel.fromJson(data, documentID)),
      queryBuilder: (query) {
        var tempQuery = query.where("fromUid", isEqualTo: userId);
            return tempQuery;
      },
      );
  }

  // Get all notification to current user
  @override
  Future<List<NotificationModel>> getAllNotificationToMe({required String userId}) async{
    return await firestoreService!.collectionSnapshot(
      path: FirestorePath.notifications(), 
      builder: ((data, documentID) => NotificationModel.fromJson(data, documentID)),
      queryBuilder: (query) {
        var tempQuery = query.where("toUid", isEqualTo: userId);
            return tempQuery;
      },
      );
  }

  @override
  Future<NotificationModel> updateNotification({required String nid}) async {
    var currentNotification = await getByNotificationId(notificationId: nid);
    currentNotification.isOpened = true;
    await setNotification(notification: currentNotification, merge: true);
    
    return currentNotification;
  }
}