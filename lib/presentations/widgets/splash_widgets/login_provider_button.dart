import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginProviderButton extends StatelessWidget {
  final Function() onProviderSelected;
  final String imgName;
  final Color backgroudColor;
  const LoginProviderButton({Key? key, required this.onProviderSelected, required this.imgName, required this.backgroudColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onProviderSelected(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
              color: backgroudColor,
              borderRadius: const BorderRadius.all(Radius.circular(45))),
          constraints: const BoxConstraints(
              maxHeight: 60,
              maxWidth: 60,
              minHeight: 60,
              minWidth: 60),
          child: Center(
              child: SvgPicture.asset(
                width: 30,
                height: 30,
                color: imgName == "linkedin" || imgName == "facebook" ? Colors.white : null,
                "lib/resources/images/$imgName.svg")),
        ),
      ),
    );
  }
}