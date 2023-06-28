
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDatePickers {
  static Future<DateTime?> showAndroidDatePicker({
    required DateTime initialDate,
    required BuildContext context,
    required DateTime firstDate,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              onPrimary: Colors.white, // selected text color
              onSurface: Colors.black, // default text color
              primary: Colors.black, // circle color
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  side:   BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != initialDate) {
      return pickedDate;
    }
    return null;
  }

  static Future<DateTime?> showIosDatePicker({
    required DateTime initialDate,
    required BuildContext context,
    required int minimumYear,
  }) async {
    DateTime? selected;
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 50,
          color: Colors.white,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
              ),
            ),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              backgroundColor: Colors.white,
              onDateTimeChanged: (DateTime value) {
                selected = value;
              },
              initialDateTime: initialDate,
              minimumYear: minimumYear,
              maximumYear: 2101,
            ),
          ),
        );
      },
    );
    return selected;
  }
}
