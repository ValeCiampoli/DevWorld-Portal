import 'package:portal/presentations/state_management/appointment_detail_provider.dart';
import 'package:portal/presentations/state_management/document_provider.dart';
import 'package:portal/presentations/state_management/memo_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:portal/commons/locator.dart';
import 'package:portal/presentations/state_management/auth_provider.dart';
import 'package:portal/presentations/state_management/new_appointment_provider.dart';
import 'package:portal/presentations/state_management/notification_provider.dart';
 import 'package:portal/presentations/state_management/appointment_provider.dart';
 import 'package:portal/presentations/state_management/user_provider.dart';

List<SingleChildWidget> providerList = [
  ChangeNotifierProvider<NewAppointmentProvider>(create: (_) => locator<NewAppointmentProvider>()),
  ChangeNotifierProvider<AppointmentListProvider>(create: (_) => locator<AppointmentListProvider>()),
  ChangeNotifierProvider<AuthProvider>(create: (_) => locator<AuthProvider>()),
  ChangeNotifierProvider<DocumentListProvider>(create: (_) => locator<DocumentListProvider>()),
  ChangeNotifierProvider<UserListProvider>(create: (_) => locator<UserListProvider>()),
  ChangeNotifierProvider<NotificationProvider>(create: (_) => locator<NotificationProvider>()),
  ChangeNotifierProvider<MemoListProvider>(create: (_) => locator<MemoListProvider>()),
  ChangeNotifierProvider<AppointmentDetailProvider>(create: (_) => locator<AppointmentDetailProvider>()),
];