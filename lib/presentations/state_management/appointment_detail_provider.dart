import 'package:flutter/material.dart';
import 'package:portal/data/models/appointement_model.dart';
import 'package:portal/data/services/interfaces/appointment_service.dart';
import 'package:portal/data/services/interfaces/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user_model.dart';

class AppointmentDetailProvider with ChangeNotifier {
  final AppointmentService? appointmentService;
  final UserService? userService;
  final SharedPreferences? sharedPreferences;

  AppointmentDetailProvider(
      {@required this.appointmentService,
      @required this.userService,
      @required this.sharedPreferences});

  bool loading = false;

  List<AppointmentModel>? _appointmentListById;
  List<UserModel>? _userListById;

  List<AppointmentModel>? get appointmentListById => _appointmentListById;
  List<UserModel>? get userListById => _userListById;

  getAppointmentUserListById({List<String>? userIds}) async {
    _startOperation();
    _userListById ??= [];
    for (var userId in userIds!) {
      var user = await userService!.getByUserId(userId: userId);
      if (user != null) _userListById!.add(user);
    }
    _endOperation();
  }

  cleanAppointmentList() async {
    _startOperation();
    _userListById = [];
    _endOperation();
  }

  // #region Methods for manage loader
  _startOperation() {
    loading = true;
    notifyListeners();
  }

  _endOperation() {
    loading = false;
    notifyListeners();
  }
// #endregion
}
