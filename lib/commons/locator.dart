import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portal/commons/firestore/firestore_service.dart';
import 'package:portal/commons/routing/router.gr.dart';
import 'package:portal/data/services/document_service_impl.dart';
import 'package:portal/data/services/interfaces/document_service.dart';
import 'package:portal/data/services/interfaces/memo_service.dart';
import 'package:portal/data/services/interfaces/notification_service.dart';
import 'package:portal/data/services/interfaces/appointment_service.dart';
 import 'package:portal/data/services/interfaces/user_service.dart';
import 'package:portal/data/services/memo_service_impl.dart';
import 'package:portal/data/services/notification_service_impl.dart';
import 'package:portal/data/services/appointment_service_impl.dart';
 import 'package:portal/data/services/user_service_impl.dart';
import 'package:portal/firebase_options.dart';
import 'package:portal/presentations/state_management/appointment_detail_provider.dart';
 import 'package:portal/presentations/state_management/auth_provider.dart';
import 'package:portal/presentations/state_management/document_provider.dart';
import 'package:portal/presentations/state_management/memo_provider.dart';
import 'package:portal/presentations/state_management/new_appointment_provider.dart';
import 'package:portal/presentations/state_management/notification_provider.dart';
 import 'package:portal/presentations/state_management/appointment_provider.dart';
import 'package:portal/presentations/state_management/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


GetIt locator = GetIt.instance;

Future<void> setupDi()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //register provider
  locator.registerFactory(
    () => AppointmentListProvider(appointmentService: locator(), userService: locator(), sharedPreferences: locator()),
  );
  locator.registerFactory(
    () => AppointmentDetailProvider(appointmentService: locator(), userService: locator(), sharedPreferences: locator()),
  );
  locator.registerFactory(
    () => DocumentListProvider(documentService: locator(), userService:locator(), sharedPreferences:locator()),
  );
  locator.registerFactory(
    () => AuthProvider(userService: locator(), sharedPreferences: locator()),
  );
  locator.registerFactory(
    () => NewAppointmentProvider(userService: locator(), postService: locator(), sharedPreferences: locator()),
  );
 
  locator.registerFactory(
    () => UserListProvider(sharedPreferences: locator(), userService: locator(), appointmentService: locator()),
  );
  
  locator.registerFactory(
    () => NotificationProvider(sharedPreferences: locator(), notificationService: locator()),
  );
  locator.registerFactory(
    () => MemoListProvider(sharedPreferences: locator(), memoService: locator()),
  );

  //register service
  locator.registerFactory<AppointmentService>(
      () => AppointmentServiceImpl(firestoreService: locator()));
  locator.registerFactory<DocumentService>(
      () => DocumentServiceImpl(firestoreService: locator()));
  locator.registerFactory<UserService>(
      () => UserServiceImpl(firestoreService: locator()));
  locator.registerFactory<NotificationService>(
      () => NotificationServiceImpl(firestoreService: locator()));
  locator.registerFactory<MemoService>(
      () => MemoServiceImpl(firestoreService: locator()));
  


  //register external dependencies
  final sharedPref = await SharedPreferences.getInstance();
  final firestoreService = FirestoreService.instance;
  locator.registerFactory(() => sharedPref);
  locator.registerFactory(() => firestoreService);
  locator.registerLazySingleton<AppRouter>(() => AppRouter());
}