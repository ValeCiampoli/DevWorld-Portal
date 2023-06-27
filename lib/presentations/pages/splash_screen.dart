import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:portal/data/models/login_provider_result_model.dart';
import 'package:portal/presentations/widgets/splash_widgets/bg_image.dart';
import 'package:portal/presentations/widgets/splash_widgets/login_alert.dart';
import 'package:portal/presentations/widgets/splash_widgets/main_sign_up.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
        builder: (context, sizingInformation) => Material(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                         children: [
                          const BGImageSplash(),
                          Positioned(
                            right: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height,
                              decoration: const BoxDecoration(color: Color.fromARGB(211, 158, 158, 158)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 15, 10, 10),
                                    child: Row(
                                      children: [
                                        sizingInformation.deviceScreenType ==
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
                                              fontWeight: FontWeight.bold),
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
                                                padding: sizingInformation
                                                            .deviceScreenType ==
                                                        DeviceScreenType.mobile
                                                    ? const EdgeInsets.symmetric(
                                                        horizontal: 20)
                                                    : const EdgeInsets.all(20),
                                                child: LogInAlert(
                                                  switchBody:
                                                      (providerLoginResult) {
                                                    setState(() {
                                                      providerResult =
                                                          providerLoginResult;
                                                      showLogin = !showLogin;
                                                    });
                                                  },
                                                ),
                                              )
                                            : Padding(
                                                padding: sizingInformation
                                                            .deviceScreenType ==
                                                        DeviceScreenType.mobile
                                                    ? const EdgeInsets.symmetric(
                                                        horizontal: 20)
                                                    : const EdgeInsets.all(20),
                                                child: MainSignUp(
                                                  providerResult: providerResult,
                                                  switchBody: () {
                                                    setState(() {
                                                      showLogin = !showLogin;
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
                    ),
                  ],
                ),
              ),
            ));
  }
}
