 

import 'package:portal/data/models/memo_model.dart';

abstract class MemoService {
  Future<void> setMemo({required MemoModel memoModel});
  Future<void> deleteMemo({required MemoModel memoModel});
  Future<List<MemoModel>> getAllMemo();

}