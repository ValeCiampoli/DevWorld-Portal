import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:portal/commons/theme.dart';
import 'package:provider/provider.dart';
import 'package:portal/data/models/login_provider_result_model.dart';
import 'package:portal/presentations/state_management/auth_provider.dart';

class MainSignUpDesktop extends StatefulWidget {
  final Function() switchBody;
  final LoginProviderResultModel? providerResult;

  const MainSignUpDesktop({
    super.key,
    required this.switchBody,
    this.providerResult,
  });

  @override
  State<MainSignUpDesktop> createState() => _MainSignUpDesktopState();
}

class _MainSignUpDesktopState extends State<MainSignUpDesktop> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
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
                      Text(tr("enter_name"),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 184, 183, 183),
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 37,
                        width: 350,
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
                            hintText: 'Inserisci Nome',
                            hintStyle: DWTextTypography.of(context).text16,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(tr("enter_surname"),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 184, 183, 183),
                              fontSize: 18,
                            ),
                          )),
                      SizedBox(
                          height: 37,
                          width: 350,
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
                              hintStyle: DWTextTypography.of(context).text16,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child:  Text(tr("enter_profession"),
                          style: TextStyle(
                            color: Color.fromARGB(255, 184, 183, 183),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 37,
                          width: 350,
                          child: DropdownSearch<String>(
                            items: role,
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  suffixIconColor: Colors.white,
                                  contentPadding: EdgeInsets.only(top: 8),
                                  hintText: 'Seleziona ruolo',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.white)),
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedRoleValue = value;
                              });
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(tr("enter_mail"),
                          style: DWTextTypography.of(context).text18.copyWith(color: Color.fromARGB(255, 184, 183, 183),
                              ),
                        ),
                      ),
                      SizedBox(
                           height: 37,
                          width: 350,
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
                            hintText: 'Inserisci email',
                            hintStyle: DWTextTypography.of(context).text16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(tr("enter_password"),
                            style: DWTextTypography.of(context).text18.copyWith(color: Color.fromARGB(255, 184, 183, 183),
                                )),
                      ),
                      SizedBox(
                           height: 37,
                          width: 350,
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
                            hintText: 'Inserisci password',
                            hintStyle: DWTextTypography.of(context).text16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0),
                        child: Text(tr("confirm_password"),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 184, 183, 183),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                           height: 37,
                          width: 350,
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
                          style: DWTextTypography.of(context).text16,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'Conferma password',
                            hintStyle: DWTextTypography.of(context).text16,
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
                        padding: const EdgeInsets.only(top: 8.0),
                        child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      onTap: () => widget.switchBody(),
                                      child: Text(tr("back_to_previous"),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )),
                                ])),
                       ),
                    ]);
                   },
            )));
    }
}
