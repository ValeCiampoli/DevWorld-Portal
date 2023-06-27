import 'package:flutter/cupertino.dart';
import 'package:portal/commons/utils.dart';
import 'package:portal/data/models/notification_model.dart';
import 'package:portal/data/services/interfaces/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider with ChangeNotifier {
  final NotificationService? notificationService;
  final SharedPreferences? sharedPreferences;

  NotificationProvider(
      {@required this.notificationService,
      @required this.sharedPreferences});

  bool loading = false;
  List<NotificationModel>? _notificationList;

  List<NotificationModel>? get notificationList => _notificationList;
  
  sendNotification({required String fromUserId, required String toUserId, required String fromFullName, required String fromImage, required bool isDoctorPremium, String? title, String? body,}) async{
    var notificationToBeSend = NotificationModel(
      nid: firestoreId(), 
      fromUid: fromUserId, 
      fromFullName: fromFullName, 
      fromImage: fromImage, 
      fromCertificate: isDoctorPremium,
      toUid: toUserId, 
      title: title, 
      body: body,
      date: DateTime.now(), 
      isOpened: false
    );
    await notificationService!.setNotification(notification: notificationToBeSend);
    notifyListeners();
  }

  getAllNotification({required String userId}) async{
    _startOperation();

    Future.delayed(const Duration(milliseconds: 200), () async {
      _notificationList = await notificationService!.getAllNotificationToMe(userId: userId);
      _endOperation();
    });
  }

  setNotificationOpened({required String userId, required String notId}) async{
    await notificationService!.updateNotification(nid: notId);
    _notificationList = await notificationService!.getAllNotificationToMe(userId: userId);
    notifyListeners();
  }

  deleteNotification({required String notId}) async{
    NotificationModel notToDelete = notificationList!.firstWhere((n) => n.nid == notId);
    _notificationList!.removeWhere((n) => n.nid == notId);
    
    await notificationService!.deleteNotification(notToDelete);
    notifyListeners();
  }

  _startOperation() {
    loading = true;
    notifyListeners();
  }

  _endOperation() {
    loading = false;
    notifyListeners();
  }
}