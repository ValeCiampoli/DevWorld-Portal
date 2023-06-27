import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portal/commons/firestore/firestore_path.dart';
import 'package:portal/data/models/document_model.dart';
import 'package:portal/data/services/interfaces/document_service.dart';

import '../../commons/firestore/firestore_service.dart';

class DocumentServiceImpl implements DocumentService {
  final FirestoreService? firestoreService;

  DocumentServiceImpl({this.firestoreService});


  // Create/Update
  // @override
  // Future<void> setDocument(
  //     {required DocumentModel appointment, bool merge = false}) async {
  //   await firestoreService!.set(
  //       path: FirestorePath.appointment(appointment.id.toString()),
  //       data: appointment.toJson(),
  //       merge: merge);
  // }
    @override
  Future<void> setDocument({required DocumentModel documentModel})async  {
   await firestoreService!.set(
        path: FirestorePath.document(documentModel.id.toString()),
        data: documentModel.toJson(),
        );
  }

  @override
  Future<void> deleteDocument({required DocumentModel documentModel})async =>
    await firestoreService!
        .deleteData(path: FirestorePath.document(documentModel.id));
  

  @override
  Future<List<DocumentModel>> getDocumentById({String? userId}) async =>
      await firestoreService!.collectionSnapshot(
        path: FirestorePath.documents(),
        builder: (data, documentID) =>
            DocumentModel.fromJson(data, documentID),
        queryBuilder: (query) {
          List<Query<Map<String, dynamic>>> queryList = [];
          if (userId != null) {
            queryList.add(query.where("userId", isEqualTo: userId));
          }
          //todo filtri
          return queryList.last;
        },
      );

  

}
