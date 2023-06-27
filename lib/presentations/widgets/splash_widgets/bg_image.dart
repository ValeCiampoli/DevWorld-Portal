import 'package:flutter/material.dart';

class BGImageSplash extends StatelessWidget {
  const BGImageSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'lib/resources/images/divider-bg.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(209, 0, 0, 0),
                Color.fromARGB(141, 0, 0, 0),
                Color.fromARGB(59, 0, 0, 0),
              ])),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Image.asset(
                'lib/resources/images/LogoDefinitivoBianco.png',
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
