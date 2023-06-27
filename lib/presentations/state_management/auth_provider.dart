// ignore_for_file: avoid_print, avoid_web_libraries_in_flutter, unused_import

import 'dart:async';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:portal/commons/enum.dart';
import 'package:portal/commons/utils.dart';
import 'package:portal/data/models/login_provider_result_model.dart';
import 'package:portal/data/models/user_model.dart';
import 'package:portal/data/services/interfaces/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { authenticated, unauthenticated, checkInProgress }

class AuthProvider extends ChangeNotifier {
  late FirebaseAuth _auth;
  final UserService? userService;
  final SharedPreferences? sharedPreferences;

  AuthProvider({@required this.userService, @required this.sharedPreferences}) {
    _auth = FirebaseAuth.instance;
    var tempId = sharedPreferences!.getString("userId");
    if (tempId != null) {
      Future.delayed(
          Duration.zero, () async => await _userFromFirebase(tempId));
    } else {
      _status = Status.unauthenticated;
      notifyListeners();
    }
  }

  //Default status
  Status _status = Status.checkInProgress;
  Status get status => _status;

  // ignore: prefer_final_fields
  UserModel _defaultUser = UserModel(
    uid: '',
    name: '',
    surname: '',
    isAdmin: false,
    mansione: '',
    mail: '',
    fcmToken: '',
  );
  UserModel get defaultUser => _defaultUser;

  UserModel? _currentUser;
  UserModel get currentUser => _currentUser ?? defaultUser;

  Future<void> updateCurrentUser({required UserModel userUpdated}) async {
    await userService!.setUser(user: userUpdated, merge: true);
    _currentUser = userUpdated;
    notifyListeners();
  }

  Future<void> fetchUser() async {
    var tempId = sharedPreferences!.getString("userId");
    if (tempId != null) {
      _currentUser = await userService!.getByUserId(userId: tempId);
      notifyListeners();
    }
  }

  Future<bool> _userFromFirebase(String? userId) async {
    _status = Status.checkInProgress;
    notifyListeners();

    if (userId == null) {
      _currentUser = _defaultUser;
      return false;
    }

    try {
      _currentUser = await userService!.getByUserId(userId: userId);
      sharedPreferences!.setString("userId", userId);

      _status = Status.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      print("Error on get user from db = ${e.toString()}");
      _currentUser = _defaultUser;
      return false;
    }
  }

  Future<bool> registerWithEmailAndPassword(
      {required String email,
      required String password,
      required String name,
      required String surname,
      required bool isAdmin,
      String? mansione}) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (result.user != null) {
        var newUser = UserModel(
          uid: result.user!.uid,
          mail: email,
          name: name,
          surname: surname,
          fcmToken: '',
          isAdmin: isAdmin,
          mansione: mansione ?? '',
        );
        await userService!.setUser(user: newUser);

        // if is professional user posticipate login after complete signin flow
        sharedPreferences!.setString("userId", result.user!.uid);
      }

      return _userFromFirebase(result.user != null ? result.user!.uid : null);
    } catch (e) {
      //TODO gestire errore "The email address is already in use by another account." per utenti che utilizzavano prima l'app
      print("Error on the new user registration = ${e.toString()}");
      _status = Status.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(result.user != null ? result.user!.uid : null);
    } catch (e) {
      print("Error on the sign in = ${e.toString()}");
      _status = Status.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> completeSignInWithProvider(
      {required String uid,
      required String email,
      required String name,
      required String surname,
      required String mansione,
      required bool isAdmin,
      List<String>? profession,
      String? description}) async {
    try {
      var newUser = UserModel(
          uid: uid,
          mail: email,
          name: name,
          surname: surname,
          fcmToken: '',
          isAdmin: isAdmin,
          mansione: mansione);

      await userService!.setUser(user: newUser);

      // if is professional user posticipate login after complete signin flow
      sharedPreferences!.setString("userId", uid);

      return _userFromFirebase(uid);
    } catch (e) {
      //TODO gestire errore "The email address is already in use by another account." per utenti che utilizzavano prima l'app
      print("Error on the new user registration = ${e.toString()}");
      _status = Status.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> completeLoginWithProvider(String userId) async {
    try {
      return _userFromFirebase(userId);
    } catch (e) {
      print("Error on the sign in = ${e.toString()}");
      _status = Status.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<LoginProviderResultModel> signInWithGoogle() async {
    var signInResult = LoginProviderResultModel();

    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      var result = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      if (result.user == null) {
        _status = Status.unauthenticated;
        notifyListeners();
        return signInResult;
      }

      signInResult.userId = result.user!.uid;
      signInResult.email = result.user!.email;

      //check if user is already registered
      try {
        // ignore: unused_local_variable
        var tempUser = await userService!.getByUserId(userId: result.user!.uid);
      } catch (e) {
        //First login of user
        print("First login of user");
        signInResult.alreadySignIn = false;
        return signInResult;
      }

      _userFromFirebase(result.user != null ? result.user!.uid : null);
      signInResult.alreadySignIn = true;
      return signInResult;
    } catch (e) {
      print("Error on the sign in = ${e.toString()}");
      _status = Status.unauthenticated;
      notifyListeners();
      return signInResult;
    }
  }

  Future<LoginProviderResultModel> signInWithApple() async {
    var signInResult = LoginProviderResultModel();

    try {
      final provider = OAuthProvider("apple.com")
        ..addScope('email')
        ..addScope('name');

      var result = await FirebaseAuth.instance.signInWithPopup(provider);

      if (result.user == null) {
        _status = Status.unauthenticated;
        notifyListeners();
        return signInResult;
      }

      signInResult.userId = result.user!.uid;
      signInResult.email = result.user!.email;

      //check if user is already registered
      try {
        // ignore: unused_local_variable
        var tempUser = await userService!.getByUserId(userId: result.user!.uid);
      } catch (e) {
        //First login of user
        print("First login of user");
        signInResult.alreadySignIn = false;
        return signInResult;
      }

      _userFromFirebase(result.user != null ? result.user!.uid : null);
      signInResult.alreadySignIn = true;
      return signInResult;
    } catch (e) {
      print("Error on the sign in = ${e.toString()}");
      _status = Status.unauthenticated;
      notifyListeners();
      return signInResult;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future signOut() async {
    sharedPreferences!.clear();
    _auth.signOut();
    _status = Status.unauthenticated;
    notifyListeners();
  }

  Future<bool> checkIfAlreadySignIn(String email) async {
    return await userService!.checkByMail(email: email);
  }

  Future<bool> resetEmail(String newEmail, String password) async {
    bool result = false;
    try {
      await _auth.signInWithEmailAndPassword(
          email: currentUser.mail, password: password);
    } catch (e) {
      //Credenziali non valide
      return result;
    }

    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      try {
        await firebaseUser.updateEmail(newEmail);
        result = true;
      } catch (e) {
        result = false;
      }
      if (result) {
        var tempUser = await userService!
            .updateEmail(userId: firebaseUser.uid, newMail: newEmail);
        _currentUser = tempUser;
        notifyListeners();
      }
    }

    return result;
  }

  Future<bool> updatePassword(String oldPassword, String newPassword) async {
    bool result = false;
    try {
      await _auth.signInWithEmailAndPassword(
          email: currentUser.mail, password: oldPassword);
    } catch (e) {
      //Credenziali non valide
      return result;
    }

    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      try {
        await firebaseUser.updatePassword(newPassword);
        result = true;
      } catch (e) {
        result = false;
      }
    }

    return result;
  }

  Future<bool> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String?> uploadFile(
      PlatformFile tempFile, String type, String id) async {
    try {
      Uint8List? uploadFile = tempFile.bytes;
      var mediaContentType = getExtention(tempFile.name, InputCreateType.url);

      FirebaseStorage storage = FirebaseStorage.instance;
      DateTime date = DateTime.now();

      Reference refCover =
          storage.ref("$id/documents/${type}_${date.toString()}");

      UploadTask task = refCover.putData(
          uploadFile!, SettableMetadata(contentType: mediaContentType));

      await task;

      var storageUrl = await FirebaseStorage.instance
          .ref()
          .child("$id/documents/${type}_${date.toString()}")
          .getDownloadURL();

      return storageUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  

  Future<void> addUserDocument(String id, String url) async {
    var user = await userService!.getByUserId(userId: id);
    user?.documents ??= [];
    user!.documents!.add(url);
    await userService!.setUser(user: user);
  }

  Future<String?> uploadImage(
      PlatformFile tempFile, String type, InputCreateType mediaType) async {
    try {
      Uint8List? uploadFile = tempFile.bytes;
      var mediaContentType = getExtention(tempFile.name, mediaType);

      FirebaseStorage storage = FirebaseStorage.instance;

      Reference refCover = storage.ref("${currentUser.uid}/$type");

      UploadTask task = refCover.putData(
          uploadFile!, SettableMetadata(contentType: mediaContentType));

      await task;

      var storageUrl = await FirebaseStorage.instance
          .ref()
          .child("${currentUser.uid}/$type")
          .getDownloadURL();

      return storageUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
