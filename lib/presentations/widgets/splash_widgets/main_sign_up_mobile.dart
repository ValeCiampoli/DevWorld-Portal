import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:portal/commons/theme.dart';
import 'package:provider/provider.dart';
import 'package:portal/data/models/login_provider_result_model.dart';
import 'package:portal/presentations/state_management/auth_provider.dart';

class MainSignUpMobile extends StatefulWidget {
  final Function() switchBody;
  final LoginProviderResultModel? providerResult;

  const MainSignUpMobile({
    super.key,
    required this.switchBody,
    this.providerResult,
  });

  @override
  State<MainSignUpMobile> createState() => _MainSignUpMobileState();
}

class _MainSignUpMobileState extends State<MainSignUpMobile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController mansioneController = TextEditingController();
  String? selectedRoleValue;
  List<String> role = ["Marketing", "Developer", "Recluting", "Area Legale"];

  bool isAdmin = false;

  int currentPage = 1;

  @override
  void initState() {
    if (widget.providerResult != null) {
      setState(() {
        currentPage = 2;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Consumer<AuthProvider>(
          builder: (context, auth, child) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/resources/images/divider-bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height + 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        Colors.black,
                        Colors.black,
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0)
                      ])),
                ),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                            child: Text('Iscriviti',
                              style: DWTextTypography.of(context).text22bold,
                            ),),
                          Text('Crea il tuo account inserendo i dati nei campi sottostanti',
                            style: DWTextTypography.of(context).text18,
                          ),
                          Padding(
                            padding:const EdgeInsets.only(top: 20.0, bottom: 0),
                            child: Text(tr("enter_name"),
                              style: DWTextTypography.of(context).text18.copyWith(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextFormField(
                              controller: nameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Inserisci un nome';
                                }
                                return null;
                              },
                              style: DWTextTypography.of(context).text18,
                              decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintText: 'Inserisci nome',
                                hintStyle: DWTextTypography.of(context).text18,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 0),
                            child: Text(tr("enter_surname"),
                              style: DWTextTypography.of(context).text18.copyWith(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextFormField(
                              controller: surnameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Inserisci un cognome';
                                }
                                return null;
                              },
                              style: DWTextTypography.of(context).text18,
                              decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintText: 'Inserisci cognome',
                                hintStyle: DWTextTypography.of(context).text18,
                              )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 0),
                            child: Text(tr("enter_profession"),
                              style: DWTextTypography.of(context).text18.copyWith(color: Colors.grey),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.white))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: DropdownSearch<String>(
                                    items: role,
                                    dropdownDecoratorProps: DropDownDecoratorProps(
                                      baseStyle: DWTextTypography.of(context).text18,
                                      dropdownSearchDecoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(top: 8, left: 0),
                                        hintText: 'Seleziona ruolo',
                                        hintStyle:DWTextTypography.of(context).text18,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedRoleValue = value;
                                      });
                                    },
                                  ),
                                )),
                          ),
                          Padding(
                            padding:const EdgeInsets.only(top: 20.0, bottom: 0),
                            child: Text(tr("enter_mail"),
                              style: DWTextTypography.of(context).text18.copyWith(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Il campo email è vuoto';
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                                    .hasMatch(emailController.text)) {
                                  return "inserisci una mail valida";
                                } else if (!RegExp('devworld.it')
                                    .hasMatch(emailController.text)) {
                                  return 'la mail deve essere abbinata a un account di DevWorld';
                                }
                                return null;
                              },
                              style: DWTextTypography.of(context).text18,
                              decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintText: 'Inserisci Email',
                                hintStyle: DWTextTypography.of(context).text18,
                              ),
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.only(top: 20.0, bottom: 0),
                            child: Text(tr("enter_password"),
                              style: DWTextTypography.of(context).text18.copyWith(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Inerisci una password';
                                } else if (value.length <= 5) {
                                  return 'Inserisci almeno 6 caratteri';
                                }
                                return null;
                              },
                              style: DWTextTypography.of(context).text18,
                              decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintText: 'Inserisci Password',
                                hintStyle: DWTextTypography.of(context).text18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 0),
                            child: Text(tr("confirm_password"),
                              style: DWTextTypography.of(context).text18.copyWith(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextFormField(
                              obscureText: true,
                              controller: confirmController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Inserisci password da confermare';
                                } else if (value != passwordController.text) {
                                  return 'Password non corrispondente';
                                }
                                return null;
                              },
                              style: DWTextTypography.of(context).text18,
                              decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintText: 'Conferma Password',
                                hintStyle: DWTextTypography.of(context).text18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthProvider>()
                                        .registerWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text,
                                            surname: surnameController.text,
                                            mansione: selectedRoleValue,
                                            isAdmin: false);
                                  }
                                },
                                child: Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(Radius.circular(8))),
                                    constraints: const BoxConstraints(
                                        maxHeight: 50,
                                        maxWidth: 400,
                                        minHeight: 30,
                                        minWidth: 100),
                                    child: Center(
                                        child: Text(
                                      tr("continue"),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: GestureDetector(
                              onTap: () => widget.switchBody(),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8))),
                                    constraints: const BoxConstraints(
                                        maxHeight: 50,
                                        maxWidth: 400,
                                        minHeight: 30,
                                        minWidth: 100),
                                    child: Center(
                                      child: Text(tr("back"),
                                          style: DWTextTypography.of(context).text16bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ])),
              ]),
            );
          },
        ));
  }
}
