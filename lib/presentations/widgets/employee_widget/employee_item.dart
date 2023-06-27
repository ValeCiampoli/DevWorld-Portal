import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portal/commons/routing/router.gr.dart';
import 'package:portal/commons/theme.dart';
import 'package:portal/commons/utils.dart';

import 'package:portal/data/models/user_model.dart';
import 'package:portal/presentations/state_management/auth_provider.dart';
import 'package:portal/presentations/state_management/document_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EmployeeListItem extends StatefulWidget {
  final UserModel user;
  const EmployeeListItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EmployeeListItem> createState() => _EmployeeListItemState();
}

class _EmployeeListItemState extends State<EmployeeListItem> {
  @override
  void initState() {
    // context.read<DocumentListProvider>().
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DocumentListProvider>(builder: (context, doc, child) {
      return ResponsiveBuilder(builder: (context, size) {
        return size.deviceScreenType == DeviceScreenType.mobile
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    AutoRouter.of(context)
                        .push(AllDocumentsRoute(userModel: widget.user));
                  },
                  onLongPress: () async {
                    await showEditEmployee(widget.user);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.24,
                          child: Center(
                              child: Text(widget.user.name,
                                  style: DWTextTypography.of(context).text16))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.24,
                          child: Center(
                              child: Text(
                            widget.user.surname,
                            style: DWTextTypography.of(context).text16,
                          ))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.24,
                          child: Center(
                              child: Text(widget.user.mansione,
                                  style: DWTextTypography.of(context).text16))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.24,
                          child: GestureDetector(
                              onTap: () async {
                                await showUploadNameDocumentDialog();
                              },
                              child: const Center(
                                  child:
                                      Icon(Icons.add, color: Colors.white)))),
                      //       SizedBox(
                      //           width: MediaQuery.of(context).size.width * 0.13,
                      //           child: Center(
                      //               child: GestureDetector(
                      //                   onTap: () {
                      //                     AutoRouter.of(context).push(AllDocumentsRoute(
                      //                         userModel: widget.user));
                      //                   },
                      //                   child: const Icon(Icons.folder)))),
                      //       SizedBox(
                      //           width: MediaQuery.of(context).size.width * 0.13,
                      //           child: Center(
                      //               child: GestureDetector(
                      //                   onTap: () async {
                      //                     await showEditEmployee(widget.user);
                      //                   },
                      //                   child: const Icon(Icons.edit))))
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.13,
                        child: Center(
                            child: Text(widget.user.name,
                                style: DWTextTypography.of(context).text16))),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.13,
                        child: Center(
                            child: Text(widget.user.surname,
                                style: DWTextTypography.of(context).text16))),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.13,
                        child: Center(
                            child: Text(widget.user.mansione,
                                style: DWTextTypography.of(context).text16))),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.13,
                        child: GestureDetector(
                            onTap: () async {
                              await showUploadNameDocumentDialog();
                            },
                            child: const Center(
                                child: Icon(
                              Icons.add,
                              color: Colors.white,
                            )))),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.13,
                        child: Center(
                            child: GestureDetector(
                                onTap: () {
                                  AutoRouter.of(context).push(AllDocumentsRoute(
                                      userModel: widget.user));
                                },
                                child: const Icon(Icons.folder,
                                    color: Colors.white)))),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.13,
                        child: Center(
                            child: GestureDetector(
                                onTap: () async {
                                  await showEditEmployee(widget.user);
                                },
                                child: const Icon(Icons.edit,
                                    color: Colors.white))))
                  ],
                ),
              );
      });
    });
  }

  Future<void> showEditEmployee(UserModel user) async {
    bool isAdmin = user.isAdmin;
    await showDialog(
      context: context,
      builder: (context) {
        return Consumer<AuthProvider>(builder: (context, authProvider, _) {
          return Dialog(
            child: Container(
              width: 350,
              height: 200,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'lib/resources/images/devworld.png',
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 30, 14, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          child: isAdmin
                              ? Text(
                                  'vuoi rendere ${'${user.name} ${user.surname} come Admin?'}')
                              : Text(
                                  'vuoi revocare a ${'${user.name} ${user.surname} i privilegi da Admin?'}'),
                        ),
                        Switch(
                          value: isAdmin,
                          onChanged: (value) async {
                            isAdmin = value;
                            await context
                                .read<AuthProvider>()
                                .updateCurrentUser(
                                    userUpdated: UserModel(
                                        uid: user.uid,
                                        name: user.name,
                                        surname: user.surname,
                                        mail: user.mail,
                                        isAdmin: isAdmin,
                                        mansione: user.mansione,
                                        fcmToken: user.fcmToken));
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Future<void> showUploadNameDocumentDialog() async {
    TextEditingController nameController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'lib/resources/images/devworld.png',
                            width: 140,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(width: 400, child: Divider()),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: SizedBox(
                        width: 350,
                        child: Text(
                          'Inserisci il nome del documento, consigliato inserire Il tipo, il mese e anno di riferimento',
                          textAlign: TextAlign.left,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
                          border: Border.all(color: Colors.black, width: 0.3)),
                      width: 200,
                      height: 35,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 5.0),
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: 'Ex: Busta Paga Gennaio 2023',
                              border: InputBorder.none),
                          controller: nameController,
                          onSubmitted: (value) {
                            nameController.text = value;
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40.0, bottom: 40, right: 20),
                    child: SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            color: Colors.blue,
                            child: const Text(
                              'Avanti',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              AutoRouter.of(context).pop();
                              await showUploadDocumentDialog(
                                  nameController.text);
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ]),
          ),
        );
      },
    );
  }

  Future<void> showUploadDocumentDialog(String nameDocs) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.white,
                    ]),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'lib/resources/images/devworld.png',
                          width: 140,
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(width: 400, child: Divider()),
                ),
                GestureDetector(
                    onTap: () async {
                      var file = await fileFromStorage(documentExtSupported);
                      if (file != null && mounted) {
                        var resBusta = await Provider.of<AuthProvider>(context,
                                listen: false)
                            .uploadFile(file, "busta paga", widget.user.uid);
                        if (resBusta == null && mounted) {
                          await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(tr("error")),
                                    content: Text(tr("error_document")),
                                  ));
                        } else {
                          // Update user on db
                          if (mounted) {
                            context
                                .read<DocumentListProvider>()
                                .publishDocument(
                                    userId: widget.user.uid,
                                    id: firestoreId(),
                                    url: resBusta,
                                    name: nameDocs,
                                    date: DateTime.now());
                            context
                                .read<AuthProvider>()
                                .addUserDocument(widget.user.uid, resBusta!);
                            context.read<AuthProvider>().fetchUser();
                            AutoRouter.of(context).pop().then((value) {
                              AutoRouter.of(context).pop();
                            });
                          }
                        }
                      }
                    },
                    child: SizedBox(
                        child: SvgPicture.asset(
                      'lib/resources/images/add.svg',
                      color: Colors.green,
                      width: 160,
                    ))),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 50.0),
                  child: SizedBox(
                      width: 240,
                      child: Text(
                        'Carica il documento che verrà salvato nello spazio dedicato al dipendente',
                        textAlign: TextAlign.center,
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
