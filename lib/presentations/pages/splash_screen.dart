import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:portal/data/models/login_provider_result_model.dart';
import 'package:portal/presentations/widgets/splash_widgets/bg_image.dart';
import 'package:portal/presentations/widgets/splash_widgets/login_alert_desktop.dart';
import 'package:portal/presentations/widgets/splash_widgets/login_alert_mobile.dart';
import 'package:portal/presentations/widgets/splash_widgets/main_sign_up_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../widgets/splash_widgets/main_sign_up_mobile.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showLogin = true;
  LoginProviderResultModel? providerResult;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, size) => Material(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    size.deviceScreenType != DeviceScreenType.mobile
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              children: [
                                const BGImageSplash(),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    width: 400,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(210, 71, 71, 71)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 15, 10, 10),
                                          child: Row(
                                            children: [
                                              size.deviceScreenType ==
                                                      DeviceScreenType.mobile
                                                  ? SizedBox(
                                                      height: 50,
                                                      width: 50,
                                                      child: Image.asset(
                                                          "lib/resources/images/devworld.png"),
                                                    )
                                                  : const SizedBox(),
                                              Text(
                                                showLogin
                                                    ? "${tr("welcome_back")}!"
                                                    : "${tr("welcome")}!",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: Colors.white,
                                          thickness: 1.4,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 20.0,
                                            bottom: 30,
                                          ),
                                          child: Wrap(
                                            children: [
                                              showLogin
                                                  ? Padding(
                                                      padding:
                                                          size.deviceScreenType ==
                                                                  DeviceScreenType
                                                                      .mobile
                                                              ? const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20)
                                                              : const EdgeInsets
                                                                  .all(20),
                                                      child: LogInAlertDesktop(
                                                        switchBody:
                                                            (providerLoginResult) {
                                                          setState(() {
                                                            providerResult =
                                                                providerLoginResult;
                                                            showLogin =
                                                                !showLogin;
                                                          });
                                                        },
                                                      ))
                                                  : Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal:20),
                                                      child: MainSignUpDesktop(
                                                        providerResult:
                                                            providerResult,
                                                        switchBody: () {
                                                          setState(() {
                                                            showLogin =
                                                                !showLogin;
                                                          });
                                                        },
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : showLogin
                            ? LogInAlertMobile(
                                switchBody: (providerLoginResult) {
                                  setState(() {
                                    providerResult = providerLoginResult;
                                    showLogin = !showLogin;
                                  });
                                },
                              )
                            : MainSignUpMobile(
                                providerResult: providerResult,
                                switchBody: () {
                                  setState(() {
                                    showLogin = !showLogin;
                                  });
                                },
                              ),
                  ],
                ),
              ),
            ));
  }
}
