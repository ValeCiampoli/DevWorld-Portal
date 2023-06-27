import 'package:flutter/material.dart';
import 'package:portal/commons/utils.dart';
import 'package:portal/data/models/memo_model.dart';
import 'package:portal/data/services/interfaces/memo_service.dart';
import 'package:portal/data/services/interfaces/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoListProvider with ChangeNotifier {
  final MemoService? memoService;
  final UserService? userService;
  final SharedPreferences? sharedPreferences;

  MemoListProvider(
      {this.memoService, this.userService, this.sharedPreferences});

  bool loading = false;
  bool loadingMedia = false;

  MemoModel? _memo;
  List<MemoModel>? _memoList;

  List<MemoModel>? get memoList => _memoList;

  MemoModel? get memo => _memo;

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

  Future deleteMemo(MemoModel? memo) async {
    if (memo != null) {
      await memoService!.deleteMemo(memoModel: memo);
      getAllMemo();
    }
    clearPostProvider();
  }

  Future<bool> publishMemo(
      {String? userId,
      String? name,
      String? body,
      double? top,
      double? left}) async {
    _startOperation();
    var tempDoctorId = sharedPreferences!.getString("userId");
    if (tempDoctorId == null) {
      _endOperation();
      return false;
    }
    // var currentUser = await userService!.getByUserId(userId: tempDoctorId);
    await memoService!.setMemo(
        memoModel: MemoModel(
            userId: userId!, id: firestoreId(), body: body!, top: 100, left: 100));
    clearPostProvider();
    _endOperation();
    return true;
  }

  Future<bool> storeNewPosition(MemoModel memo) async {
    _startOperation();
    var tempDoctorId = sharedPreferences!.getString("userId");
    if (tempDoctorId == null) {
      _endOperation();
      return false;
    }
    deleteMemo(memo);
    await memoService!.setMemo(
        memoModel: MemoModel(
            userId: memo.userId,
            id: memo.id,
            body: memo.body,
            top: memo.top,
            left: memo.left));
    clearPostProvider();
    return true;
  }

  Future clearPostProvider() async {
    _memo = null;
    notifyListeners();
  }

  getAllMemo() async {
    _startOperation();

    Future.delayed(const Duration(milliseconds: 500), () async {
      _memoList = await memoService!.getAllMemo();

      _endOperation();
    });
  }

  cleanListProvider() async {
    _startOperation();
    _memoList = null;
    _endOperation();
  }
}
