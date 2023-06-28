import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portal/commons/theme.dart';
import 'package:portal/presentations/state_management/auth_provider.dart';
import 'package:portal/presentations/state_management/user_provider.dart';
import 'package:portal/presentations/widgets/employee_widget/employee_item.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<UserListProvider>().getAllUsers();
    });
    super.initState();
  }

  List<String> role = ["Test", "Admin", "Marketin", "Developer", "Recluting"];
  String? selectedRoleValue;
  bool isFilterActive = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context).currentUser;
    return ResponsiveBuilder(builder: (context, size) {
      return Consumer<UserListProvider>(builder: (context, users, child) {
        return users.userList == null
            ? Container(
                color: Colors.black,
                width: size.deviceScreenType == DeviceScreenType.mobile
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width - 60,
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: LoadingAnimationWidget.beat(
                  color: const Color.fromARGB(255, 255, 177, 59),
                  size: 60,
                )),
              )
            : Padding(
              padding: const EdgeInsets.only(top:0.0),
              child: Container(
                  color: Colors.black,
                  width: size.deviceScreenType == DeviceScreenType.mobile
                      ? MediaQuery.of(context).size.width
                      : MediaQuery.of(context).size.width - 60,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Visibility(
                        visible: user.isAdmin,
                        child: Container(
                          color:Colors.black,
                          height: 70,
                          child: Row(
                            children: [
                              size.deviceScreenType == DeviceScreenType.mobile ||
                                      size.deviceScreenType ==
                                          DeviceScreenType.tablet
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'lib/resources/images/LogoDefinitivoBianco.png',
                                        width: 200,
                                      ),
                                    ),
                              Expanded(child: Container()),
                              Container(
                                width: size.deviceScreenType == DeviceScreenType.mobile ? 180 : 240,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 0.3),
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: DropdownSearch<String>(
                                    items: role,
                                    dropdownDecoratorProps:
                                        const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                        hintText: 'Filtra per ruolo',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedRoleValue = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    await context
                                        .read<UserListProvider>()
                                        .filterList(role: selectedRoleValue);
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 0.3),
                                        color: Colors.blue,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: const Center(
                                        child: Text(
                                      'Filtra',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                              // size.deviceScreenType == DeviceScreenType.mobile
                              //     ? SizedBox()
                              //     :
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      selectedRoleValue = '';
                                    });
                                    context.read<UserListProvider>().filterList();
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blue, width: 1),
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: const Center(
                                        child: Text(
                                      'Azzera filtri',
                                      style: TextStyle(color: Colors.blue),
                                    )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: user.isAdmin,
                        child: const Divider(
                          height: 0,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: SizedBox(
                          child: size.deviceScreenType == DeviceScreenType.mobile
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.24,
                                          child: Center(
                                              child: Text(
                                            'Nome',
                                            style: DWTextTypography.of(context)
                                                .text16bold
                                                .copyWith(
                                                    fontWeight: FontWeight.w600),
                                          ))),
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.24,
                                          child: Center(
                                              child: Text(
                                            'Cognome',
                                            style: DWTextTypography.of(context)
                                                .text16bold
                                                .copyWith(
                                                    fontWeight: FontWeight.w600),
                                          ))),
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.24,
                                          child: Center(
                                              child: Text(
                                            'Mansione',
                                            style: DWTextTypography.of(context)
                                                .text16bold
                                                .copyWith(
                                                    fontWeight: FontWeight.w600),
                                          ))),
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.24,
                                          child: Center(
                                              child: Text(
                                            'Azioni',
                                            style: DWTextTypography.of(context)
                                                .text16bold
                                                .copyWith(
                                                    fontWeight: FontWeight.w600),
                                          ))),
                                    ])
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.13,
                                        child: Center(
                                            child: Text(
                                          'Nome',
                                          style: DWTextTypography.of(context)
                                              .text16bold
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ))),
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.13,
                                        child: Center(
                                            child: Text(
                                          'Cognome',
                                          style: DWTextTypography.of(context)
                                              .text16bold
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ))),
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.13,
                                        child: Center(
                                            child: Text(
                                          'Mansione',
                                          style: DWTextTypography.of(context)
                                              .text16bold
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ))),
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.13,
                                        child: Center(
                                            child: Text(
                                          'Aggiungi DOC',
                                          style: DWTextTypography.of(context)
                                              .text16bold
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ))),
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.13,
                                        child: Center(
                                            child: Text(
                                          'Documenti',
                                          style: DWTextTypography.of(context)
                                              .text16bold
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ))),
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.13,
                                        child: Center(
                                            child: Text(
                                          'Modifica',
                                          style: DWTextTypography.of(context)
                                              .text16bold
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        )))
                                  ],
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 171,
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: users.userList!.length,
                            itemBuilder: (context, index) {
                              return EmployeeListItem(
                                  user: users.userList![index]);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            );
      });
    });
  }
}
