import 'package:flutter/material.dart';

extension DWTextTypography on TextTheme {
  static TextTheme of(BuildContext context) => Theme.of(context).textTheme;
  TextStyle get text22 => const TextStyle(
      fontFamily: 'SF',
      fontStyle: FontStyle.normal,
      fontSize: 22,
      color: Colors.white);
  TextStyle get text18 => const TextStyle(
      fontFamily: 'SF',
      fontStyle: FontStyle.normal,
      fontSize: 18,
      color: Colors.white);
  TextStyle get text16 => const TextStyle(
      fontFamily: 'SF',
      fontStyle: FontStyle.normal,
      fontSize: 16,
      color: Colors.white);
  TextStyle get text14 => const TextStyle(
      fontFamily: 'SF',
      fontStyle: FontStyle.normal,
      fontSize: 14,
      color: Colors.white);
  TextStyle get text12 => const TextStyle(
      fontFamily: 'SF',
      fontStyle: FontStyle.normal,
      fontSize: 12,
      color: Colors.white);
  TextStyle get text10 => const TextStyle(
      fontFamily: 'SF',
      fontStyle: FontStyle.normal,
      fontSize: 10,
      color: Colors.white);

  TextStyle get text22bold => const TextStyle(
      fontFamily: 'SF',
      fontStyle: FontStyle.normal,
      fontSize: 22,
      color: Colors.white,
      fontWeight: FontWeight.w700);
  TextStyle get text18bold => const TextStyle(
      fontFamily: 'SF',
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontSize: 18,
      fontWeight: FontWeight.w700);
  TextStyle get text16bold => const TextStyle(
        fontFamily: 'SF',
        color: Colors.white,
        fontStyle: FontStyle.normal,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );
  TextStyle get text14bold => const TextStyle(
      fontFamily: 'SF',
      fontStyle: FontStyle.normal,
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w700);
  TextStyle get text12bold => const TextStyle(
      fontFamily: 'SF',
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontSize: 12,
      fontWeight: FontWeight.w700);
  TextStyle get text10bold => const TextStyle(
      fontFamily: 'SF',
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontSize: 10,
      fontWeight: FontWeight.w700);
}
