import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portal/presentations/pages/all_documents_screen.dart';
import 'package:portal/presentations/pages/calendar_screen.dart';
import 'package:portal/presentations/pages/employee_screen.dart';
import 'package:portal/presentations/pages/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:portal/commons/enum.dart';
import 'package:portal/presentations/state_management/auth_provider.dart';
import 'package:portal/presentations/pages/splash_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  List<Widget> bodyWidget = [
    const HomeScreen(),
    const CalendarScreen(),
    const EmployeeScreen(),
    const AllDocumentsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context).currentUser;
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      if (auth.status == Status.unauthenticated) {
        return const SplashScreen();
      } else if (auth.status == Status.authenticated) {
        return Material(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: MediaQuery.of(context).size.height,
                    color: const Color.fromARGB(255, 209, 209, 209),
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                            icon: const Icon(
                              Icons.home,
                              color: Color.fromARGB(255, 65, 65, 65),
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                            icon: const Icon(
                              Icons.calendar_month,
                              size: 25,
                              color: Color.fromARGB(255, 65, 65, 65),
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (user.isAdmin) {
                                  selectedIndex = 2;
                                } else {
                                  selectedIndex = 3;
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.folder,
                              color: Color.fromARGB(255, 65, 65, 65),
                            )),
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: IconButton(
                              onPressed: () async {
                                await context.read<AuthProvider>().signOut();
                              },
                              icon:
                                  const Icon(Icons.logout, color: Colors.red)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: bodyWidget.elementAt(selectedIndex),
                  )
                ],
              )
            ]),
          ),
        );
      }
      return Center(
          child: LoadingAnimationWidget.beat(
        color: const Color.fromARGB(255, 255, 177, 59),
        size: 60,
      ));
    });
  }

  PopupMenuItem<Options> _buildPopupMenuItem(String title, Options position) {
    return PopupMenuItem<Options>(
      value: position,
      child: Column(
        children: [
          Text(title),
        ],
      ),
    );
  }
}
