import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 import 'package:portal/data/models/login_provider_result_model.dart';
import 'package:portal/presentations/state_management/auth_provider.dart';
 
class LogInAlertDesktop extends StatefulWidget {
  final Function(LoginProviderResultModel? providerResult) switchBody;

  const LogInAlertDesktop({
    super.key,
    required this.switchBody,
  });

  @override
  State<LogInAlertDesktop> createState() => _LogInAlertDesktopState();
}

class _LogInAlertDesktopState extends State<LogInAlertDesktop> {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
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
            padding:
                const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 20),
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: TextFormField(
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
                          controller: emailController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(bottom: 8, left: 10),
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w500),
                              border: InputBorder.none,
                              hintText: "Email"),
                        ),
                      )),
                ],
              ),
            ),
          ),
           Text(
            tr("enter_password"),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 20),
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Inerisci una password';
                            }
                            return null;
                          },
                          controller: passwordController,
                          obscureText: true,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(bottom: 8, left: 10),
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w500),
                              border: InputBorder.none,
                              hintText: "Password"),
                        ),
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 00.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async{
                  if(formKey.currentState!.validate())
                  {
                    await authProvider.signInWithEmailAndPassword(emailController.text, passwordController.text);
                    if(mounted){
                      if(authProvider.status == Status.unauthenticated){
                        showDialog(
                          context: context,
                          builder: (context) =>  AlertDialog(
                            content: Text(
                              tr("login_error")
                            ),
                            actions: const [],)
                        );
                      }else{
                        AutoRouter.of(context).pop();
                      }
                    }
                  }
                },
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    constraints: const BoxConstraints(
                        maxHeight: 45,
                        maxWidth: 400,
                        minHeight: 30,
                        minWidth: 100),
                    child:  Center(
                        child: Text(
                       tr("login"),
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
            padding: const EdgeInsets.only(top: 8, bottom: 12),
            child: Align(
              alignment: Alignment.topRight,
              child: MouseRegion(
              cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    showResetPasswordDialog();
                  },
                  child: Text(
                    tr("reset_password"),
                    style: const TextStyle(
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
            padding: const EdgeInsets.only(top: 10.0, bottom: 8),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Center(
                  child: GestureDetector(
                onTap: () => widget.switchBody(null),
                child:  RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: tr("no_account"),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500), 
                    children: [
                      TextSpan(
                        text: tr("signin_hint"),
                        style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold), 
                      )
                    ]
                  )
                ),
              )),
            ),
          ),
         
       ],
      ),
    );
  }

  void showResetPasswordDialog() async{
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
        content: 
        Form(
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
                              contentPadding: EdgeInsets.only(
                                      bottom: 14,
                                      left: 10),
                              border: InputBorder.none,),
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
        var res = await context.read<AuthProvider>().resetPassword(email: resetPasswordController.text);
        if(!res && mounted){
         }
      }
      resetPasswordController.text = "";
    });
  }
}
