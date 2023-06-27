 

import 'package:portal/data/models/document_model.dart';

abstract class DocumentService {
  Future<void> setDocument({required DocumentModel documentModel});
  Future<void> deleteDocument({required DocumentModel documentModel});
  Future<List<DocumentModel>> getDocumentById({required String userId});

}