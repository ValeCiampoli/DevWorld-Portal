import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentModel extends Appointment {
  List<String>? userId;
  String? url;

  AppointmentModel({
    super.startTimeZone,
    this.userId,
    this.url,
    super.endTimeZone,
    super.recurrenceRule,
    super.isAllDay = false,
    super.notes,
    super.location,
    super.resourceIds,
    super.recurrenceId,
    required super.id,
    required super.startTime,
    required super.endTime,
    super.subject = '',
    super.color = Colors.lightBlue,
    super.recurrenceExceptionDates,
  }) : super();

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'url': url,
      'startTimeZone': startTimeZone,
      'endTimeZone': endTimeZone,
      'recurrenceRule': recurrenceRule,
      'isAllDay': isAllDay,
      'notes': notes,
      'location': location,
      'id': id,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'subject': subject,
      'color': color.value,
      'recurrenceExceptionDates': recurrenceExceptionDates
          ?.map((x) => x.millisecondsSinceEpoch)
          .toList(),
    };
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> map, String id) {
    return AppointmentModel(
      userId: map['userId'] != null ? (map['userId'] as List).map((item) => item as String).toList() : null,
      url: map['url'],
      startTimeZone: map['startTimeZone'],
      endTimeZone: map['endTimeZone'],
      recurrenceRule: map['recurrenceRule'],
      isAllDay: map['isAllDay'] ?? false,
      notes: map['notes'],
      location: map['location'],
      id: map['id'],
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      subject: map['subject'] ?? '',
      color: Color(map['color']),
      recurrenceExceptionDates: map['recurrenceExceptionDates'] != null
          ? List<DateTime>.from(map['recurrenceExceptionDates']
              ?.map((x) => DateTime.fromMillisecondsSinceEpoch(x)))
          : null,
    );
  }
}
