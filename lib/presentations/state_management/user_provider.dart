import 'package:flutter/material.dart';
import 'package:portal/data/models/user_model.dart';
import 'package:portal/data/services/interfaces/appointment_service.dart';
import 'package:portal/data/services/interfaces/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserListProvider with ChangeNotifier{
  final UserService? userService;
  final AppointmentService? appointmentService;
  final SharedPreferences? sharedPreferences;
  
  UserListProvider({@required this.userService, @required this.appointmentService, @required this.sharedPreferences});

  bool loading = false;
  
  List<UserModel>? _userList;

  List<UserModel>? _userSearched;
  List<UserModel>? _userFiltered;

  UserModel? _userDetail;
  
  List<UserModel>? get userList => _userList;

  List<UserModel>? get userSearched => _userSearched;
  List<UserModel>? get userFiltered => _userFiltered;
  UserModel? get userDetail => _userDetail;


  

  getAllUsers() async{
    _startOperation();
    
    Future.delayed(const Duration(milliseconds: 500), () async {
      _userList = await userService!.getAllUsers(); 
      _endOperation(); 
    });
  }

  search() async{
    _startOperation();
    
    Future.delayed(const Duration(milliseconds: 500), () async {
      _userSearched = await userService!.searchUsers(); 
      _endOperation(); 
    });
  }

  searchAllUser() async{
    _startOperation();
    
    Future.delayed(const Duration(milliseconds: 500), () async {
      _userSearched = await userService!.searchAllUser(); 
      _endOperation(); 
    });
  }

  getUserDetail({required String userId}) async{
    _startOperation();

    Future.delayed(const Duration(milliseconds: 500), () async {
      _userDetail = await userService!.getByUserId(userId: userId);
      _endOperation(); 
    });
  }

  filterList({String? role}) async{
    _startOperation();
    List<UserModel> filteredList = [];
    _userList = await userService!.getAllUsers(); 
    if (userList != null) {
      filteredList = userList!.where((element) => element.mansione == role!).toList();
       _userList = filteredList;
    } else {
      filteredList = getAllUsers();
      _userList = filteredList;
    }
    _endOperation();
  }

  filterUserById({List<String>? userIds}) async {
    _startOperation();
      List<UserModel> filteredList = [];
      _userList = await userService!.getAllUsers(); 
      if (_userList != null && userIds != null) {
          filteredList = _userList!.where((element) => userIds.contains(element.uid)).toList();
          _userFiltered = filteredList;
      }
        
        
        
      

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