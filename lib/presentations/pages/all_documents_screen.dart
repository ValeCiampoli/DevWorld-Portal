import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portal/commons/routing/router.gr.dart';
import 'package:portal/commons/theme.dart';
import 'package:portal/commons/utils.dart';
import 'package:portal/data/models/document_model.dart';
import 'package:portal/data/models/user_model.dart';
import 'package:portal/presentations/state_management/auth_provider.dart';
import 'package:portal/presentations/state_management/document_provider.dart';
import 'package:portal/presentations/widgets/all_documents_widgets/docuement_list_Item.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AllDocumentsScreen extends StatefulWidget {
  const AllDocumentsScreen({super.key, this.userModel});
  // final String? id;
  final UserModel? userModel;
  @override
  State<AllDocumentsScreen> createState() => _AllDocumentsScreenState();
}

class _AllDocumentsScreenState extends State<AllDocumentsScreen> {
  List<DocumentModel>? listDocuments;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<DocumentListProvider>().cleanListProvider();
      await context
          .read<DocumentListProvider>()
          .getDocumentById(widget.userModel?.uid);
    });

    super.initState();
  }

  List<String> year = ['2020', '2021', '2022', '2023'];
  String? selectedYearValue;

  List<String> month = [
    'Gennaio',
    'Febbraio',
    'Marzo',
    'Aprile',
    'Maggio',
    'Giugno',
    'Luglio',
    'Agosto',
    'Settembre',
    'Ottobre',
    'Novembre',
    'Dicembre'
  ];

  List<String> docType = [
    'Busta Paga',
    'Congedo',
  ];
  String? selectedTypeValue;

  String? selectedMonthValue;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context).currentUser;
    return ResponsiveBuilder(builder: (context, size) {
      return Material(
        child:
            Consumer<DocumentListProvider>(builder: (context, document, child) {
          return document.documentListById == null
              ? Container(
                color: Colors.black,
                  width: size.deviceScreenType == DeviceScreenType.mobile
                      ? MediaQuery.of(context).size.width
                      : MediaQuery.of(context).size.width - 60,
                  height: MediaQuery.of(context).size.height - 70,
                  child: Center(
                      child: LoadingAnimationWidget.beat(
                    color: const Color.fromARGB(255, 255, 177, 59),
                    size: 60,
                  )),
                )
              : SizedBox(
                  width: size.deviceScreenType == DeviceScreenType.mobile
                      ? MediaQuery.of(context).size.width
                      : MediaQuery.of(context).size.width - 60,
                  child: document.documentListById!.isEmpty
                      ? Material(
                          child: Column(
                            children: [
                              Container(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                child: Padding(
                                  padding: size.deviceScreenType !=
                                              DeviceScreenType.mobile ||
                                          size.deviceScreenType ==
                                              DeviceScreenType.tablet
                                      ? const EdgeInsets.all(0)
                                      : const EdgeInsets.only(top: 50.0),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await context
                                              .read<DocumentListProvider>()
                                              .cleanListProvider();
                                          // AutoRouter.of(context).pop();
                                          AutoRouter.of(context)
                                              .replace(const MainRoute());
                                        },
                                        child: size.deviceScreenType ==
                                                DeviceScreenType.mobile
                                            ? const SizedBox.shrink()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Image.asset(
                                                  'lib/resources/images/LogoDefinitivoBianco.png',
                                                  width: 200,
                                                ),
                                              ),
                                      ),
                                      size.deviceScreenType ==
                                              DeviceScreenType.mobile
                                          ? const SizedBox()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '${widget.userModel?.name ?? user.name} ${widget.userModel?.surname ?? user.surname}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                      Expanded(child: Container()),
                                      size.deviceScreenType ==
                                              DeviceScreenType.mobile
                                          ? GestureDetector(
                                              onTap: () async {
                                                await showUploadNameDialog(user,
                                                    widget.userModel?.uid);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(8)),
                                                    border: Border.all(
                                                        color: Colors.blue)),
                                                child: const Center(
                                                    child: Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Icon(Icons.add),
                                                )),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () async {
                                                await showUploadNameDialog(user,
                                                    widget.userModel?.uid);
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 130,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(8)),
                                                    border: Border.all(
                                                        color: Colors.blue)),
                                                child: const Center(
                                                  child: Text(
                                                    'Carica Documento',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              ),
                                            ),
                                      size.deviceScreenType ==
                                              DeviceScreenType.mobile
                                          ? const SizedBox.shrink()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: 190,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 0.3),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: DropdownSearch<String>(
                                                    items: month,
                                                    dropdownDecoratorProps:
                                                        const DropDownDecoratorProps(
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Filtra per mese',
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                    onChanged: (value) {
                                                      selectedMonthValue =
                                                          value;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                      size.deviceScreenType ==
                                              DeviceScreenType.mobile
                                          ? const SizedBox.shrink()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Container(
                                                width: 190,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 0.3),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: DropdownSearch<String>(
                                                    items: year,
                                                    dropdownDecoratorProps:
                                                        const DropDownDecoratorProps(
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Filtra per anno',
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                    onChanged: (value) {
                                                      selectedYearValue = value;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                      Padding(
                                        padding: size.deviceScreenType ==
                                                DeviceScreenType.mobile
                                            ? const EdgeInsets.only(left: 8.0)
                                            : const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: size.deviceScreenType ==
                                                  DeviceScreenType.mobile
                                              ? 150
                                              : 190,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 0.3),
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: DropdownSearch<String>(
                                              items: docType,
                                              dropdownDecoratorProps:
                                                  const DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintText: 'Filtra Doc',
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                              onChanged: (value) {
                                                selectedTypeValue = value;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () async {
                                            await context
                                                .read<DocumentListProvider>()
                                                .filterDocument(
                                                  id: widget.userModel?.uid ??
                                                      user.uid,
                                                  type: selectedTypeValue,
                                                  month: selectedMonthValue,
                                                  year: selectedYearValue,
                                                ); //selectedRoleValue);
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0.3),
                                                color: Colors.blue,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            child: const Center(
                                                child: Text(
                                              'Filtra',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: GestureDetector(
                                          onTap: () async {
                                            context
                                                .read<DocumentListProvider>()
                                                .filterDocument();
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue,
                                                    width: 1),
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            child: const Center(
                                                child: Text(
                                              'Azzera filtri',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.black,
                                width: size.deviceScreenType ==
                                        DeviceScreenType.mobile
                                    ? MediaQuery.of(context).size.width
                                    : MediaQuery.of(context).size.width,
                                height:
                                size.deviceScreenType !=
                                        DeviceScreenType.mobile
                                    ?MediaQuery.of(context).size.height:
                                    MediaQuery.of(context).size.height - 106,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Non sono stati ancora caricati documenti',
                                      style:
                                          DWTextTypography.of(context).text18,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          AutoRouter.of(context).pop();
                                        },
                                        child: Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Colors.blue),
                                          child: Center(
                                            child: Text(
                                              'Torna alla pagina precedente',
                                              style:
                                                  DWTextTypography.of(context).text18bold.copyWith(fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 150,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            color: const Color.fromARGB(255, 9, 9, 9),
                            child: Column(
                              children: [
                                Container(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  child: Padding(
                                    padding: size.deviceScreenType !=
                                                DeviceScreenType.mobile ||
                                            size.deviceScreenType ==
                                                DeviceScreenType.tablet
                                        ? const EdgeInsets.all(0)
                                        : const EdgeInsets.only(top: 50.0),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await context
                                                .read<DocumentListProvider>()
                                                .cleanListProvider();
                                            // AutoRouter.of(context).pop();
                                            AutoRouter.of(context)
                                                .replace(const MainRoute());
                                          },
                                          child: size.deviceScreenType ==
                                                  DeviceScreenType.mobile
                                              ? const SizedBox.shrink()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Image.asset(
                                                    'lib/resources/images/LogoDefinitivoBianco.png',
                                                    width: 200,
                                                  ),
                                                ),
                                        ),
                                        size.deviceScreenType ==
                                                DeviceScreenType.mobile
                                            ? const SizedBox()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  '${widget.userModel?.name ?? user.name} ${widget.userModel?.surname ?? user.surname}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                        Expanded(child: Container()),
                                        size.deviceScreenType ==
                                                DeviceScreenType.mobile
                                            ? GestureDetector(
                                                onTap: () async {
                                                  await showUploadNameDialog(
                                                      user,
                                                      widget.userModel?.uid);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  8)),
                                                      border: Border.all(
                                                          color: Colors.blue)),
                                                  child: const Center(
                                                      child: Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Icon(Icons.add),
                                                  )),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () async {
                                                  await showUploadNameDialog(
                                                      user,
                                                      widget.userModel?.uid);
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 130,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  8)),
                                                      border: Border.all(
                                                          color: Colors.blue)),
                                                  child: const Center(
                                                    child: Text(
                                                      'Carica Documento',
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        size.deviceScreenType ==
                                                DeviceScreenType.mobile
                                            ? const SizedBox.shrink()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 190,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.3),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child:
                                                        DropdownSearch<String>(
                                                      items: month,
                                                      dropdownDecoratorProps:
                                                          const DropDownDecoratorProps(
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Filtra per mese',
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        selectedMonthValue =
                                                            value;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        size.deviceScreenType ==
                                                DeviceScreenType.mobile
                                            ? const SizedBox.shrink()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Container(
                                                  width: 190,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.3),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child:
                                                        DropdownSearch<String>(
                                                      items: year,
                                                      dropdownDecoratorProps:
                                                          const DropDownDecoratorProps(
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Filtra per anno',
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        selectedYearValue =
                                                            value;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        Padding(
                                          padding: size.deviceScreenType ==
                                                  DeviceScreenType.mobile
                                              ? const EdgeInsets.only(left: 8.0)
                                              : const EdgeInsets.only(
                                                  right: 8.0),
                                          child: Container(
                                            width: size.deviceScreenType ==
                                                    DeviceScreenType.mobile
                                                ? 150
                                                : 190,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0.3),
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: DropdownSearch<String>(
                                                items: docType,
                                                dropdownDecoratorProps:
                                                    const DropDownDecoratorProps(
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    hintText: 'Filtra Doc',
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  selectedTypeValue = value;
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () async {
                                              await context
                                                  .read<DocumentListProvider>()
                                                  .filterDocument(
                                                    id: widget.userModel?.uid ??
                                                        user.uid,
                                                    type: selectedTypeValue,
                                                    month: selectedMonthValue,
                                                    year: selectedYearValue,
                                                  ); //selectedRoleValue);
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 0.3),
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: const Center(
                                                  child: Text(
                                                'Filtra',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: GestureDetector(
                                            onTap: () async {
                                              context
                                                  .read<DocumentListProvider>()
                                                  .filterDocument();
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.blue,
                                                      width: 1),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: const Center(
                                                  child: Text(
                                                'Azzera filtri',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                size.deviceScreenType == DeviceScreenType.mobile
                                    ? SizedBox(
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Visibility(
                                                visible: user.isAdmin,
                                                child: SizedBox(
                                                  child: GestureDetector(
                                                      onTap: () async {
                                                        await document
                                                            .cleanListProvider();
                                                        if (mounted) {
                                                          AutoRouter.of(context)
                                                              .pop();
                                                        }
                                                      },
                                                      child: const Icon(
                                                        Icons.arrow_back,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.22,
                                                  child: Text(
                                                    'Data',
                                                    style: DWTextTypography.of(
                                                            context)
                                                        .text18bold
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  )),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.22,
                                                  child: Text(
                                                    'Nome',
                                                    style: DWTextTypography.of(
                                                            context)
                                                        .text18bold
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  )),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.22,
                                                  child: Text(
                                                    'Scarica',
                                                    style: DWTextTypography.of(
                                                            context)
                                                        .text18bold
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  )),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.22,
                                                  child: Text(
                                                    'Azioni',
                                                    style: DWTextTypography.of(
                                                            context)
                                                        .text18bold
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Visibility(
                                                visible: user.isAdmin,
                                                child: SizedBox(
                                                  child: GestureDetector(
                                                      onTap: () async {
                                                        await document
                                                            .cleanListProvider();
                                                        if (mounted) {
                                                          AutoRouter.of(context)
                                                              .pop();
                                                        }
                                                      },
                                                      child: const Icon(
                                                        Icons.arrow_back,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.22,
                                                  child: Text(
                                                    'Data Documento',
                                                    style: DWTextTypography.of(
                                                            context)
                                                        .text18bold
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  )),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.22,
                                                  child: Text(
                                                    'Nome Documento',
                                                    style: DWTextTypography.of(
                                                            context)
                                                        .text18bold
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  )),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.22,
                                                  child: Text(
                                                    'Link',
                                                    style: DWTextTypography.of(
                                                            context)
                                                        .text18bold
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  )),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.22,
                                                  child: Text(
                                                    'Azioni',
                                                    style: DWTextTypography.of(
                                                            context)
                                                        .text18bold
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                Container(
                                  color: Colors.black,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return DocumentItem(
                                          document:
                                              document.documentListById![index],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider();
                                      },
                                      itemCount:
                                          document.documentListById!.length),
                                )
                              ],
                            ),
                          ),
                        ),
                );
        }),
      );
    });
  }

  Future<void> showUploadNameDialog(UserModel user, String? id) async {
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
                      width: 240,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.3),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownSearch<String>(
                          items: docType,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: 'Scegli un tipo di Documento',
                              border: InputBorder.none,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              nameController.text = value!;
                            });
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
                                  nameController.text,
                                  user,
                                  widget.userModel?.uid);
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

  Future<void> showUploadDocumentDialog(
      String nameDocs, UserModel user, String? id) async {
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
                            .uploadFile(file, "busta paga", user.uid);
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
                            await context
                                .read<DocumentListProvider>()
                                .publishDocument(
                                    userId: id ?? user.uid,
                                    id: firestoreId(),
                                    url: resBusta,
                                    name: nameDocs,
                                    date: DateTime.now());
                            // ignore: use_build_context_synchronously
                            await context
                                .read<AuthProvider>()
                                .addUserDocument(user.uid, resBusta!);
                            // ignore: use_build_context_synchronously
                            await context.read<AuthProvider>().fetchUser();
                            // ignore: use_build_context_synchronously
                            await context
                                .read<DocumentListProvider>()
                                .getDocumentById(
                                    widget.userModel?.uid ?? user.uid);

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
