import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:portal/commons/enum.dart';

DateTime? convertTimeStampToDateTime(dynamic dateFromFirestore) {
  if (dateFromFirestore == null) {
    return null;
  } else {
    var converted = dateFromFirestore as Timestamp;
    return converted.toDate();
  }
}

const textInputDecoration = InputDecoration(
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(bottom: 8, left: 10),
);

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String firestoreId() => getRandomString(28);

List<String> imageExtSupported = ["jpg", "jpeg", "png"];
List<String> videoExtSupported = ["mp4", "mov"];
List<String> audioExtSupported = ["mp3", "mpeg"];
List<String> documentExtSupported = ['pdf'];

String getExtention(String name, InputCreateType type){
  var subs = name.split('.');
  var ext = subs.last;
  switch (type) {
    case InputCreateType.image:
      if (imageExtSupported.contains(ext)) {
        return "image/$ext"; 
      }
      break;
    case InputCreateType.video:
      if (videoExtSupported.contains(ext)) {
        return "video/$ext";
      }
      break;
    case InputCreateType.audio:
      if (audioExtSupported.contains(ext)) {
        return "audio/$ext";
      }
      break;
    case InputCreateType.url:
      if (documentExtSupported.contains(ext)) {
        return "application/$ext";
      }
      break;
    default:
  }
  
  return ext;
}

Future<PlatformFile?> fileFromStorage(List<String> extension) async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extension
      );

    if (result != null) {
      PlatformFile file = result.files.first;
      if(extension == imageExtSupported && file.size > (1048 * 1048)){
        return null;
      } else if (extension == videoExtSupported && file.size > (1048 * 1048 * 100)){
        return null;
      } else if (extension == audioExtSupported && file.size > (1048 * 1048 * 1000) ){
        return null;
      } else if (extension == documentExtSupported && file.size > (1048 * 1048)) {
        return null;
      }
      return file;
    } else {
      return null;
    }
  }

 
 
  Future<PlatformFile?> uploadImage(BuildContext context, DeviceScreenType screenType,) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null ) {
      final blobUrl = pickedFile.path;
      debugPrint('picked blob: $blobUrl');
      // ignore: use_build_context_synchronously
      // return await cropImage(context, screenType, blobUrl, pickedFile.name); 
    } return null;
  }

  String formattedDate(DateTime inputDate) {
    final DateTime now = inputDate;
    //final DateFormat formatter = DateFormat('dd-MM-yyyy', 'it_IT');
    final DateFormat formatter = DateFormat('dd-MM-yyyy', 'it_IT');
    final String formatted = formatter.format(now);
    return formatted;
  }
  
  String formattedTime(DateTime inputDate) {
    final DateTime now = inputDate;
    final DateFormat formatter = DateFormat('HH:mm', 'it_IT');
    final String formatted = formatter.format(now);
    return formatted;
  }

   String formattedDay(DateTime inputDate) {
    final DateTime now = inputDate;
    //final DateFormat formatter = DateFormat('dd-MM-yyyy', 'it_IT');
    final DateFormat formatter = DateFormat('dd', 'it_IT');
    final String formatted = formatter.format(now);
    return formatted;
  }
  String formattedMonth(DateTime inputDate) {
    final DateTime now = inputDate;
    //final DateFormat formatter = DateFormat('dd-MM-yyyy', 'it_IT');
    final DateFormat formatter = DateFormat('MM', 'it_IT');
    final String formatted = formatter.format(now);
    return convertMonthInLetter(formatted);
  }
  
  String convertMonthInLetter(String month){
    switch (month) {
      case '01':
        return 'Gen';
      case '02':
        return 'Feb';
      case '03':
        return 'Mar';
      case '04':
        return 'Apr';
      case '05':
        return 'Mag';
      case '06':
        return 'Giu';
      case '07':
        return 'Lug';
      case '08':
        return 'Ago';
      case '09':
        return 'Set';
      case '10':
        return 'Ott';
      case '11':
        return 'Nov';
      case '12':
        return 'Dic';
      default:
        return '';
    }
  }


  Color chooseColor(int? index) {
    switch (index) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.pink;
      case 3:
        return Colors.amber;
      case 4:
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }
