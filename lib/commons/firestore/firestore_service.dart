import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> set({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false, //add setOption in set to use it
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    // ignore: avoid_print
    print('$path: $data');
    await reference.set(data, SetOptions(merge: merge));
  }

//   Future<void> bulkSet({
//     required String path,
//     required List<Map<String, dynamic>> datas,
//     bool merge = false,
//   }) async {
//     final reference = FirebaseFirestore.instance.doc(path);
//     final batchSet = FirebaseFirestore.instance.batch();

// //    for()
// //    batchSet.

//     // ignore: avoid_print
//     print('$path: $datas');
//   }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    // ignore: avoid_print
    print('delete: $path');
    await reference.delete();
  }

  Future<List<T>> collectionSnapshot<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
    Query<Map<String, dynamic>> Function(CollectionReference<Map<String,dynamic>> query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query<Map<String, dynamic>>? customQuery;
    CollectionReference<Map<String,dynamic>> query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      customQuery = queryBuilder(query);

      final Future<QuerySnapshot> customSnapshots = customQuery.get();
      return customSnapshots.then((snapshot) {
        final result = snapshot.docs
            .map((snapshot) =>
                builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((value) => value != null)
            .toList();
        if (sort != null) {
          result.sort(sort);
        }
        return result;
      });
    }
    
    final Future<QuerySnapshot> snapshots = query.get();
    return snapshots.then((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Future<T> documentSnapshot<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Future<DocumentSnapshot> snapshots = reference.get();
    return snapshots.then((snapshot) =>
        builder(snapshot.data() as Map<String, dynamic>, snapshot.id));
  }
}