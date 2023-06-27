import 'package:flutter/material.dart';
import 'package:portal/data/models/document_model.dart';
import 'package:portal/data/services/interfaces/document_service.dart';
import 'package:portal/data/services/interfaces/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentListProvider with ChangeNotifier {
  final DocumentService? documentService;
  final UserService? userService;
  final SharedPreferences? sharedPreferences;

  DocumentListProvider(
      {this.documentService, this.userService, this.sharedPreferences});

  bool loading = false;
  bool loadingMedia = false;

  DocumentModel? _document;
  List<DocumentModel>? _documentListById;

  List<DocumentModel>? get documentListById => _documentListById;

  DocumentModel? get document => _document;

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

  Future deleteDocument(DocumentModel? docs) async {
    if (docs != null) {
      await documentService!.deleteDocument(documentModel: docs);
      getDocumentById(docs.userId);
    }
    clearPostProvider();
  }

  Future<bool> publishDocument({
    DateTime? date,
    String? userId,
    String? name,
    String? id,
    String? url,
  }) async {
    _startOperation();
    var tempDoctorId = sharedPreferences!.getString("userId");
    if (tempDoctorId == null) {
      _endOperation();
      return false;
    }
    // var currentUser = await userService!.getByUserId(userId: tempDoctorId);
    await documentService!.setDocument(
        documentModel: DocumentModel(
      userId: userId!,
      id: id!,
      date: date!,
      name: name!,
      url: url!,
    ));
    clearPostProvider();
    _endOperation();
    return true;
  }

  Future clearPostProvider() async {
    _document = null;
    notifyListeners();
  }

  getDocumentById(String? id) async {
    _startOperation();

    Future.delayed(const Duration(milliseconds: 500), () async {
      var tempUserId = sharedPreferences!.getString("userId");
      if (id != null) {
        _documentListById = await documentService!.getDocumentById(userId: id);
      } else {
        _documentListById =
            await documentService!.getDocumentById(userId: tempUserId!);
      }
      _endOperation();
    });
  }

  filterDocument({String? id,String? type, String? month,String? year}) async {
     _startOperation();
    var tempUserId = sharedPreferences!.getString("userId");
    List<DocumentModel> filteredList = [];
    _documentListById = await documentService!.getDocumentById(userId: id ?? tempUserId!); 
    if (documentListById != null) {
      filteredList = documentListById!.where((element) => element.name == type!).toList();
      // filteredList = documentListById!.where((element) => element.date.month.toString().contains(month!)).toList();
      // filteredList = documentListById!.where((element) => element.date.year.toString().contains(year!)).toList();
       _documentListById = filteredList;
    } else {
      filteredList = await documentService!.getDocumentById(userId: tempUserId!); 
      _documentListById = filteredList;
    }
    _endOperation();
  }

  cleanListProvider() async {
    _startOperation();
    _documentListById = null;
    _endOperation();
  }
}
