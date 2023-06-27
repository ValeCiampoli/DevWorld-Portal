import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:portal/commons/theme.dart';
import 'package:provider/provider.dart';
import 'package:portal/data/models/login_provider_result_model.dart';
import 'package:portal/presentations/state_management/auth_provider.dart';

class LogInAlertMobile extends StatefulWidget {
  final Function(LoginProviderResultModel? providerResult) switchBody;

  const LogInAlertMobile({
    super.key,
    required this.switchBody,
  });

  @override
  State<LogInAlertMobile> createState() => _LogInAlertMobileState();
}

class _LogInAlertMobileState extends State<LogInAlertMobile> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TextEditingController resetPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Form(
      key: formKey,
      child: Stack(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'lib/resources/images/divider-bg.jpg',
                fit: BoxFit.cover,
              )),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                Image.asset(
                  "lib/resources/images/LogoDefinitivoBianco.png",
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                  child: Text(
                    'Sign In',
                    style: DWTextTypography.of(context).text22bold,
                  ),
                ),
                Text(
                  'Benvenuto in DevWorld Portal',
                  style: DWTextTypography.of(context).text18,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 0),
                  child: Text(
                    'Email',
                    style: DWTextTypography.of(context)
                        .text18
                        .copyWith(color: Colors.grey),
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
                      hintText: 'Inserisci Mail',
                      hintStyle: DWTextTypography.of(context).text18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 0),
                  child: Text(
                    'Password',
                    style: DWTextTypography.of(context)
                        .text18
                        .copyWith(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Inerisci una password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 12),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          showResetPasswordDialog();
                        },
                        child: const Text(
                          "Password dimenticata? chiama chri",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 00.0),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await authProvider.signInWithEmailAndPassword(
                              emailController.text, passwordController.text);
                          if (mounted) {
                            if (authProvider.status == Status.unauthenticated) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: Text(tr("login_error")),
                                        actions: const [],
                                      ));
                            } else {
                              AutoRouter.of(context).pop();
                            }
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Center(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            constraints: const BoxConstraints(
                                maxHeight: 50,
                                maxWidth: 400,
                                minHeight: 30,
                                minWidth: 100),
                            child: Center(
                              child: Text(tr("login"),
                                  style:
                                      DWTextTypography.of(context).text16bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => widget.switchBody(null),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.blue),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        constraints: const BoxConstraints(
                            maxHeight: 50,
                            maxWidth: 400,
                            minHeight: 30,
                            minWidth: 100),
                        child: Center(
                          child: Text("Iscriviti",
                              style: DWTextTypography.of(context).text16bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      //todo remove comment sots
      // child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [

      //      Text(
      //       tr("enter_password"),
      //       style: const TextStyle(
      //         color: Colors.white,
      //         fontSize: 18,
      //       ),
      //     ),
      //     Padding(
      //       padding:
      //           const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 20),
      //       child: Container(
      //         decoration: const BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(8),
      //                 bottomLeft: Radius.circular(8),
      //                 bottomRight: Radius.circular(8),
      //                 topRight: Radius.circular(8))),
      //         child: Row(
      //           children: [

      //     Padding(
      //       padding: const EdgeInsets.only(top: 8, bottom: 12),
      //       child: Align(
      //         alignment: Alignment.topRight,
      //         child: MouseRegion(
      //         cursor: SystemMouseCursors.click,
      //           child: GestureDetector(
      //             onTap: () {
      //               showResetPasswordDialog();
      //             },
      //             child: Text(
      //               tr("reset_password"),
      //               style: const TextStyle(
      //                 decoration: TextDecoration.underline,
      //                 color: Colors.white,
      //                 fontSize: 15,
      //                 fontWeight: FontWeight.w500),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(top: 10.0, bottom: 8),
      //       child: MouseRegion(
      //         cursor: SystemMouseCursors.click,
      //         child: Center(
      //             child: GestureDetector(
      //           onTap: () => widget.switchBody(null),
      //           child:  RichText(
      //             textAlign: TextAlign.center,
      //             text: TextSpan(
      //               text: tr("no_account"),
      //               style: const TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 15,
      //                 fontWeight: FontWeight.w500),
      //               children: [
      //                 TextSpan(
      //                   text: tr("signin_hint"),
      //                   style: const TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 17,
      //                   fontWeight: FontWeight.bold),
      //                 )
      //               ]
      //             )
      //           ),
      //         )),
      //       ),
      //     ),

      //  ],
      // ),
    );
  }

  void showResetPasswordDialog() async {
    await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          tr("reset_password"),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        contentPadding: const EdgeInsets.all(12),
        content: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8.0),
                child: Text(
                  tr("recover_email"),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 240, 240, 240),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: SizedBox(
                    height: 37,
                    width: 250,
                    child: TextFormField(
                      controller: resetPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Inserisci email valida";
                        } else {
                          return null;
                        }
                      },
                      maxLines: 1,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 14, left: 10),
                        border: InputBorder.none,
                      ),
                    )),
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            color: Colors.red,
            onPressed: () {
              AutoRouter.of(context).pop(false);
            },
            child: Text(
              tr("back"),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                AutoRouter.of(context).pop(true);
              }
            },
            child: Text(
              tr("send_reset"),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ).then((valueFromDialog) async {
      if (valueFromDialog != null && valueFromDialog) {
        var res = await context
            .read<AuthProvider>()
            .resetPassword(email: resetPasswordController.text);
        if (!res && mounted) {}
      }
      resetPasswordController.text = "";
    });
  }
}
