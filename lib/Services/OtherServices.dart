import 'dart:io' as Io;
import 'dart:convert';
import 'package:agrosnap/Provider/RemindersNotififier.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class OtherServices{
  static getImgFromPhone({required bool isCamera,required bool base64}) async{
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: (isCamera)?ImageSource.camera:ImageSource.gallery);
    if(image!=null){
      if(!base64)
        return image;
      else {
        final bytes = Io.File(image.path).readAsBytesSync();
        String img64 = base64Encode(bytes);
        return img64;
      }
    }
  }

  static Future<void> datePicker({required BuildContext context,required bool dark}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2100),
      builder: (context,child){
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: (dark)?ColorScheme.dark(primary: Constants.darkLoop,surface: Constants.darkLoop)
                : ColorScheme.light(primary: Constants.primaryColor),
            dialogBackgroundColor: (dark)?Constants.darkBlueLight:null
          ),
          child: child!,
        );
      }
    );
    if(pickedDate!=null){
      String date = getDateForm(day: pickedDate.day, dMonth: pickedDate.month,
          dWeekDay: pickedDate.weekday,arabic:true);
      String date2 = getDateForm(day: pickedDate.day, dMonth: pickedDate.month,
          dWeekDay: pickedDate.weekday,arabic:false);
      Provider.of<RemindersNotifier>(context,listen: false).setDate(dDate: date,
          dDate2: date2,day: (pickedDate.weekday==1)?7:pickedDate.weekday-1,dateTime:pickedDate);
    }
  }

  static Future<void> timePicker({required BuildContext context,required bool dark}) async{
    TimeOfDay? pickedTime = await showTimePicker(
      context: context, initialTime: TimeOfDay.now(),
      builder: (context,child){
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: (dark)?ColorScheme.dark(primary: Constants.darkLoop)
                : ColorScheme.light(primary: Constants.primaryColor),
          ),
          child: child!,
        );
      }
    );
    if(pickedTime!=null){
      String time = getTimeForm(tHour: pickedTime.hour, tMinute: pickedTime.minute,arabic:true);
      String time2 = getTimeForm(tHour: pickedTime.hour, tMinute: pickedTime.minute,arabic:false);
      Provider.of<RemindersNotifier>(context,listen: false).setTime(tTime: time,tTime2: time2,
          hours: pickedTime.hour,minutes: pickedTime.minute);
    }
  }

  static String getDateForm({
    required int day,required int dMonth,required int dWeekDay,bool arabic=true}) {
    String month="";
    String weekDay="";
    switch (dMonth) {
      case 1:
        month = (arabic)?"يناير":"Jan";
        break;
      case 2:
        month = (arabic)?"فبراير":"Feb";
        break;
      case 3:
        month = (arabic)?"مارس":"Mar";
        break;
      case 4:
        month = (arabic)?"ابريل":"Apr";
        break;
      case 5:
        month = (arabic)?"مايو":"May";
        break;
      case 6:
        month = (arabic)?"يونيو":"Jun";
        break;
      case 7:
        month = (arabic)?"يوليو":"Jul";
        break;
      case 8:
        month = (arabic)?"أغسطس":"Aug";
        break;
      case 9:
        month = (arabic)?"سبتمبر":"Sep";
        break;
      case 10:
        month = (arabic)?"أكتوبر":"Oct";
        break;
      case 11:
        month = (arabic)?"نوفمبر":"Nov";
        break;
      case 12:
        month = (arabic)?"ديسيمبر":"Dec";
        break;
    }

    switch (dWeekDay) {
      case 1:
        weekDay = (arabic)?"الأثنين":"Mon";
        break;
      case 2:
        weekDay = (arabic)?"الثلاثاء":"Tues";
        break;
      case 3:
        weekDay = (arabic)?"الأربعاء":"Wed";
        break;
      case 4:
        weekDay = (arabic)?"الخميس":"Thurs";
        break;
      case 5:
        weekDay = (arabic)?"الجمعة":"Fri";
        break;
      case 6:
        weekDay = (arabic)?"السبت":"Sat";
        break;
      case 7:
        weekDay = (arabic)?"الأحد":"Sun";
        break;
    }
    return "$weekDay $day $month";
  }

  static String getTimeForm({required int tHour,required int tMinute,bool arabic=true}){
    String time = (arabic)?"صباحًا":"AM";
    if(tHour>12){
      tHour-=12;
      time=(arabic)?"مساءً":"PM";
    }
    else if(tHour==12)
      time=(arabic)?"مساءً":"PM";
    else if(tHour==0){
      tHour=12;
      time = (arabic)?"صباحًا":"AM";
    }
    return "$tHour:$tMinute $time";
  }
}