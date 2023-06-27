import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portal/commons/utils.dart';
import 'package:portal/data/data_sorce/calendar_data_source.dart';
import 'package:portal/data/models/appointement_model.dart';
import 'package:portal/presentations/state_management/appointment_detail_provider.dart';
import 'package:portal/presentations/state_management/appointment_provider.dart';
import 'package:portal/presentations/state_management/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class Showcase extends StatefulWidget {
  const Showcase({super.key});

  @override
  State<Showcase> createState() => _ShowcaseState();
}

class _ShowcaseState extends State<Showcase> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<AppointmentListProvider>().getAppointmentsById(null);
      if (mounted) {
        await context.read<UserListProvider>().getAllUsers();
      }
    });
    super.initState();
  }

  AppointmentModel? appointmentModel;
  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentListProvider>(builder: (context, pro, child) {
      return Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 300,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(13)),
              color: Color.fromARGB(255, 234, 234, 234),
            ),
            child: pro.appointmentListByMe == null
                ? SizedBox(
                    child: Center(
                        child: LoadingAnimationWidget.beat(
                      color: const Color.fromARGB(255, 255, 177, 59),
                      size: 60,
                    )),
                  )
                : SfCalendar(
                    onLongPress: (calendarLongPressDetails) {
                      showDetail(calendarLongPressDetails);
                    },
                    view: CalendarView.day,
                    onTap: (calendarTapDetails) async {
                      if (calendarTapDetails.appointments != null) {
                        //showEditDialog(calendarTapDetails);
                      } else {
                        //showCreateDialog(calendarTapDetails);
                      }
                    },
                    dataSource:
                        MeetingDataSource(pro.appointmentListByMe ?? []),
                  ),
          ));
    });
  }

  Future<void> showDetail(
      CalendarLongPressDetails calendarLongPressDetails) async {
    await context.read<AppointmentDetailProvider>().cleanAppointmentList();
    // ignore: use_build_context_synchronously
    await context.read<AppointmentDetailProvider>().getAppointmentUserListById(
        userIds: calendarLongPressDetails.appointments!.first.userId);
    if (mounted) {
      await showDialog(
          context: context,
          builder: (context) {
            return Consumer<AppointmentDetailProvider>(
                builder: (context, pro, _) {
              return Center(
                child: SizedBox(
                  width: 500,
                  height: 500,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 500,
                            height: 100,
                            color:
                                calendarLongPressDetails.appointments![0].color,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: SizedBox(
                                  width: 500,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 53,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              formattedDay(
                                                  calendarLongPressDetails
                                                      .appointments![0]
                                                      .startTime),
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              formattedMonth(
                                                  calendarLongPressDetails
                                                      .appointments![0]
                                                      .startTime),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 53,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'dalle: ',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      formattedTime(
                                                          calendarLongPressDetails
                                                              .appointments![0]
                                                              .startTime),
                                                      style: const TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'alle: ',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    formattedTime(
                                                        calendarLongPressDetails
                                                            .appointments![0]
                                                            .endTime),
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 500,
                        height: 300,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Titolo Evento',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      calendarLongPressDetails
                                          .appointments!.first.subject,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Partecipanti',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // ListView.builder(itemBuilder: (context, index) {

                                  // },),
                                  SizedBox(
                                    height: 30,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: pro.userListById!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 0.4),
                                                color: const Color.fromARGB(
                                                    255, 221, 221, 221),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(4))),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                    '${pro.userListById![index].name} ${pro.userListById![index].surname}',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Link',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    height: 20,
                                    child: GestureDetector(
                                      onTap: () {
                                        launchUrl(calendarLongPressDetails
                                            .appointments![0].url);
                                      },
                                      child: Text(
                                          calendarLongPressDetails
                                                  .appointments![0].url ??
                                              '',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          });
    }
    void launchURL(String link) async {
      final url = Uri.encodeFull(link);
      await launchUrl(Uri.parse(url));
    }
  }
}
