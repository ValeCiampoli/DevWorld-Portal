import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:portal/commons/firestore/firestore_path.dart';
import 'package:portal/commons/firestore/firestore_service.dart';
import 'package:portal/data/services/interfaces/appointment_service.dart';

import '../models/appointement_model.dart';

class AppointmentServiceImpl implements AppointmentService {
  final FirestoreService? firestoreService;

  AppointmentServiceImpl({@required this.firestoreService});

  // Create/Update
  @override
  Future<void> setAppointment(
      {required AppointmentModel appointment, bool merge = false}) async {
    await firestoreService!.set(
        path: FirestorePath.appointment(appointment.id.toString()),
        data: appointment.toJson(),
        merge: merge);
  }

  // Delete
  @override
  Future<void> deleteAppointment(
      {required AppointmentModel appointment}) async {
    await firestoreService!
        .deleteData(path: FirestorePath.appointment(appointment.id.toString()));
  }

  // Get all
  @override
  Future<List<AppointmentModel>> getAllForHome(
      {bool? includePro, List<String>? doctorIds}) async {
    return await firestoreService!.collectionSnapshot(
        path: FirestorePath.appointments(),
        builder: ((data, documentID) =>
            AppointmentModel.fromJson(data, documentID)),
        queryBuilder: (query) {
          List<Query<Map<String, dynamic>>> queryList = [];
          // queryList.add(query.where("isPrivate", isEqualTo: false));
          // queryList.add(queryList.last.where("isPublished", isEqualTo: true));
          // if(includePro != null){
          //   queryList.add(queryList.last.where("isFromPro", isEqualTo: includePro));
          // }
          // if(doctorIds != null){
          //   queryList.add(queryList.last.where("doctorId", whereIn: doctorIds));
          // }
          return queryList.last;
        },
        sort: ((lhs, rhs) => lhs.startTime.compareTo(rhs.startTime)) //TO check
        );
  }

  // Get by postId
  @override
  Future<AppointmentModel> getByAppointmentId({required String postId}) async =>
      await firestoreService!.documentSnapshot(
        path: FirestorePath.appointment(postId),
        builder: (data, documentId) =>
            AppointmentModel.fromJson(data, documentId),
      );

  @override
  Future<List<AppointmentModel>> getAllAppointmentByAndForMe({String? userId}) async =>
      await firestoreService!.collectionSnapshot(
        path: FirestorePath.appointments(),
        builder: (data, documentID) =>
            AppointmentModel.fromJson(data, documentID),
        queryBuilder: (query) {
          List<Query<Map<String, dynamic>>> queryList = [];
          if (userId != null) {
            queryList.add(query.where("userId", arrayContains: userId));
          }
          //todo filtri
          return queryList.last;
        },
      );
}
//   // Get all sections from the same post based on pid, this call should be used only on postdetail view
