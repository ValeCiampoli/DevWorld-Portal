 import 'package:portal/commons/firestore/firestore_path.dart';
 import 'package:portal/data/models/memo_model.dart';
import 'package:portal/data/services/interfaces/memo_service.dart';

import '../../commons/firestore/firestore_service.dart';

class MemoServiceImpl implements MemoService {
  final FirestoreService? firestoreService;

  MemoServiceImpl({this.firestoreService});

  @override
  Future<void> setMemo({required MemoModel memoModel}) async {
    await firestoreService!.set(
      path: FirestorePath.memo(memoModel.id.toString()),
      data: memoModel.toJson(),
    );
  }

  @override
  Future<void> deleteMemo({required MemoModel memoModel}) async =>
      await firestoreService!
          .deleteData(path: FirestorePath.memo(memoModel.id));

  @override
  Future<List<MemoModel>> getAllMemo({String? userId}) async =>
      await firestoreService!.collectionSnapshot(
        path: FirestorePath.memoes(),
        builder: (data, documentId) => MemoModel.fromJson(data, documentId),
      );
}
