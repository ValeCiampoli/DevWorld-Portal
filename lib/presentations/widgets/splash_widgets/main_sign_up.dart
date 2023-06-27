import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portal/data/models/login_provider_result_model.dart';
import 'package:portal/presentations/state_management/auth_provider.dart';

class MainSignUp extends StatefulWidget {
  final Function() switchBody;
  final LoginProviderResultModel? providerResult;

  const MainSignUp({
    super.key,
    required this.switchBody,
    this.providerResult,
  });

  @override
  State<MainSignUp> createState() => _MainSignUpState();
}

class _MainSignUpState extends State<MainSignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController mansioneController = TextEditingController();
  String? selectedRoleValue;
  List<String> role = ["Test", "Admin", "Marketin", "Developer", "Recluting"];

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
    return Container(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: Form(
            key: _formKey,
            child: Consumer<AuthProvider>(
              builder: (context, auth, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("enter_mail"),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4, left: 4, right: 4, bottom: 20),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            child: SizedBox(
                                height: 37,
                                width: 270,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: TextFormField(
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
                                    controller: emailController,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            bottom: 8, left: 10),
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        border: InputBorder.none,
                                        hintText: "Email"),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("enter_password"),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4, left: 4, right: 4, bottom: 20),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            child: SizedBox(
                                height: 37,
                                width: 270,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Inerisci una password';
                                      } else if (value.length <= 5) {
                                        return 'Inserisci almeno 6 caratteri';
                                      }
                                      return null;
                                    },
                                    controller: passwordController,
                                    obscureText: true,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            bottom: 8, left: 10),
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        border: InputBorder.none,
                                        hintText: "Password"),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("enter_password"),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4, left: 4, right: 4, bottom: 20),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            child: Row(
                              children: [
                                SizedBox(
                                    height: 37,
                                    width: 270,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Inserisci password da confermare';
                                          } else if (value !=
                                              passwordController.text) {
                                            return 'Password non corrispondente';
                                          }
                                          return null;
                                        },
                                        controller: confirmController,
                                        obscureText: true,
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                bottom: 8, left: 10),
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500),
                                            border: InputBorder.none,
                                            hintText: "Conferma Password"),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("enter_name"),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4, left: 4, right: 4, bottom: 20),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            child: Row(
                              children: [
                                SizedBox(
                                    height: 37,
                                    width: 270,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Inserisci un nome';
                                          }
                                          return null;
                                        },
                                        controller: nameController,
                                        obscureText: false,
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                bottom: 8, left: 10),
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500),
                                            border: InputBorder.none,
                                            hintText: "Nome"),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("enter_surname"),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4, left: 4, right: 4, bottom: 20),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            child: Row(
                              children: [
                                SizedBox(
                                    height: 37,
                                    width: 270,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Inserisci un cognome';
                                          }
                                          return null;
                                        },
                                        controller: surnameController,
                                        obscureText: false,
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                bottom: 8, left: 10),
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500),
                                            border: InputBorder.none,
                                            hintText: "Cognome"),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Inserisci Mansione",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4, left: 4, right: 4, bottom: 20),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            child: SizedBox(
                                height: 37,
                                width: 270,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: DropdownSearch<String>(
                                    items: role,
                                    dropdownDecoratorProps:
                                        const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 8, left: 10),
                                        hintText: 'Seleziona ruolo',
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
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 00.0),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<AuthProvider>()
                                      .registerWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          surname: surnameController.text,
                                          mansione: selectedRoleValue,
                                          isAdmin: false);
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                constraints: const BoxConstraints(
                                    maxHeight: 45,
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
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () => widget.switchBody(),
                                  child: Text(
                                    tr("back_to_previous"),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )),
                            ],
                          )),
                    ),
                  ],
                );
              },
            )));
  }
}
