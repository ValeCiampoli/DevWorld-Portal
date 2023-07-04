// ignore_for_file: avoid_print

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal/data/models/appointement_model.dart';
import 'package:portal/data/models/section_model.dart';
import 'package:portal/data/services/interfaces/appointment_service.dart';
import 'package:portal/data/services/interfaces/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewAppointmentProvider with ChangeNotifier {
  final AppointmentService? postService;
  final UserService? userService;
  final SharedPreferences? sharedPreferences;

  NewAppointmentProvider(
      {@required this.postService,
      @required this.userService,
      @required this.sharedPreferences});

  bool loading = false;
  bool loadingMedia = false;

  AppointmentModel? _appointment;
  // ignore: prefer_final_fields
  List<SectionModel> _sectionList = [];

  AppointmentModel? get appointment => _appointment;
  List<SectionModel> get sectionList => _sectionList;

  List<String> mediaContentRemoved = [];

// #endregion

// #region Methods for manage loader
  _startOperation() {
    loading = true;
    notifyListeners();
  }

  _endOperation() {
    loading = false;
    notifyListeners();
  }

  _startMediaOperation() {
    loadingMedia = true;
    notifyListeners();
  }

  _endMediaOperation() {
    loadingMedia = false;
    notifyListeners();
  }
// #endregion

// #region Methods for Manage Post in Draft and Published

  Future deletePost() async {
    if (appointment != null) {
      await postService!.deleteAppointment(appointment: appointment!);
    }
    clearPostProvider();
  }

  Future saveAndExit(
      {String? title,
      PlatformFile? imageUploaded,
      String? mainImageRef,
      List<String>? tags}) async {
    await postService!.setAppointment(appointment: appointment!);

    clearPostProvider();
  }

//  Future<bool> checkSlotAppointment(List<String>? userIds,DateTime? startDate,DateTime? endDate,) async{

//  }

  Future<bool> publishAppoitnemt(
      {DateTime? startDate,
      String? url,
      DateTime? endDate,
      Color? color,
      String? subject,
      String? id,
      List<String>? userIds,
      }) async {
    _startOperation();
    var tempDoctorId = sharedPreferences!.getString("userId");
    if (tempDoctorId == null) {
      _endOperation();
      return false;
    }
    // var currentUser = await userService!.getByUserId(userId: tempDoctorId);
    await postService!.setAppointment(
        appointment: AppointmentModel(
            userId: userIds!,
            id: id,
            startTime: startDate!,
            endTime: endDate!,
            subject: subject!,
            color: color!,
            url: url
            ));
    clearPostProvider();
    _endOperation();
    return true;
  }

  Future clearPostProvider() async {
    _appointment = null;
    _sectionList = [];
    notifyListeners();
  }

// #endregion

// #region Methods for Manage media in firebase storage

// #endregion
}
