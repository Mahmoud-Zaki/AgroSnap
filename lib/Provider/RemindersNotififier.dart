import 'package:agrosnap/Models/PlantCare.dart';
import 'package:agrosnap/Services/LocalDBHelper.dart';
import 'package:agrosnap/Services/Notifications.dart';
import 'package:agrosnap/Services/OtherServices.dart';
import 'package:agrosnap/Services/SharedPreference.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:flutter/material.dart';

class RemindersNotifier extends ChangeNotifier{
  bool repeat = false;
  String duration = "يوم";
  String number = "1";
  int durationInt = 1,numberInt = 1,hour = 0,minute = 0, numOfDay = 1;
  DateTime dateTimeSC = DateTime.now();
  int? typeOfAlarm;
  PlantCare plantCare=PlantCare(name: "");
  String img = "";
  TextEditingController name = TextEditingController();
  String? typeName;
  String date = OtherServices.getDateForm(day: DateTime.now().day, dMonth: DateTime.now().month,
      dWeekDay: DateTime.now().weekday,arabic: true);
  String date2 = OtherServices.getDateForm(day: DateTime.now().day, dMonth: DateTime.now().month,
      dWeekDay: DateTime.now().weekday,arabic: false);
  String time = OtherServices.getTimeForm(tHour: DateTime.now().hour, tMinute: DateTime.now().minute,arabic: true);
  String time2 = OtherServices.getTimeForm(tHour: DateTime.now().hour, tMinute: DateTime.now().minute,arabic: false);
  List<PlantCare> plantsCare=[];
  DBHelper dbHelper = DBHelper();

  String get getDate => date;
  String get getTime => time;
  String get getDate2 => date2;
  String get getTime2 => time2;
  String get getImg => img;
  bool get getRepeat => repeat;

  void setSwitchValue({required bool value}){
    repeat = value;
    notifyListeners();
  }

  void setDateTimeNow(){
    date = OtherServices.getDateForm(day: DateTime.now().day, dMonth: DateTime.now().month,
        dWeekDay: DateTime.now().weekday,arabic: true);
    date2 = OtherServices.getDateForm(day: DateTime.now().day, dMonth: DateTime.now().month,
        dWeekDay: DateTime.now().weekday,arabic: false);
    time = OtherServices.getTimeForm(tHour: DateTime.now().hour, tMinute: DateTime.now().minute,arabic: true);
    time2 = OtherServices.getTimeForm(tHour: DateTime.now().hour, tMinute: DateTime.now().minute,arabic: false);
  }

  void getImgFromPhone({required bool isCamera}) async{
    img = await OtherServices.getImgFromPhone(isCamera: isCamera, base64: true);
    notifyListeners();
  }

  void setDefaultDurationNumber(){
    duration = "يوم";
    number = "1";
    durationInt=1;
    numberInt=1;
  }

  void setDate({required String dDate,required String dDate2,required int day,required DateTime dateTime}){
    date = dDate;
    date2 = dDate2;
    numOfDay=day;
    dateTimeSC=dateTime;
    notifyListeners();
  }

  void setDuration({required String value,required int index}){
    duration = value;
    durationInt = index+1;
  }

  void setNumber({required int value}){
    number = value.toString();
    numberInt = value;
  }

  void setTime({required String tTime,required String tTime2,required int hours,required int minutes}){
    time = tTime;
    time2 = tTime2;
    hour=hours;
    minute=minutes;
    notifyListeners();
  }

  void getPlants({required bool arabic})async{
    plantsCare.clear();
    await dbHelper.getMainPlants(arabic: arabic).then((plants) {
      plants.forEach((plant) {
        plantsCare.add(PlantCare.fromMap(plant));
      });
    });
    plantsCare.forEach((element) async {
      element.img= await SharedPreferenceHandler.getImg(id: element.id!);
    });
    notifyListeners();
  }

  void getTodayPlants({required bool arabic})async{
    plantsCare.clear();
    await dbHelper.getTodayPlants(con: date2,arabic: arabic).then((plants) {
      plants.forEach((plant) {
        plantsCare.add(PlantCare.fromMap(plant));
      });
    });
    plantsCare.forEach((element) async {
      element.img= await SharedPreferenceHandler.getImg(id: element.id!);
    });
    notifyListeners();
  }

  void deletePlant({required int id,required int listIndex})async{
    await dbHelper.delete(id).then((_) {
      plantsCare.removeAt(listIndex);
      SharedPreferenceHandler.removeImg(id: id);
    });
    notifyListeners();
    NotificationsService.cancelNotification(id: int.parse("1$id"));
    NotificationsService.cancelNotification(id: int.parse("2$id"));
    NotificationsService.cancelNotification(id: int.parse("3$id"));
    NotificationsService.cancelNotification(id: int.parse("4$id"));
  }

  void deleteType({required int index,required bool arabic})async{
    switch(index){
      case 0:{
        plantCare.waterizationDate=null;
        plantCare.waterizationTime=null;
        plantCare.waterizationDate2=null;
        plantCare.waterizationTime2=null;
        plantCare.waterizationRepeat=null;
        plantCare.waterizationRepeat2=null;
        NotificationsService.cancelNotification(id: int.parse("1${plantCare.id}"));
      }
      break;
      case 1:{
        plantCare.fertilizationDate=null;
        plantCare.fertilizationTime=null;
        plantCare.fertilizationDate2=null;
        plantCare.fertilizationTime2=null;
        plantCare.fertilizationRepeat=null;
        plantCare.fertilizationRepeat2=null;
        NotificationsService.cancelNotification(id: int.parse("2${plantCare.id}"));
      }
      break;
      case 2:{
        plantCare.harvestDate=null;
        plantCare.harvestTime=null;
        plantCare.harvestDate2=null;
        plantCare.harvestTime2=null;
        plantCare.harvestRepeat=null;
        plantCare.harvestRepeat2=null;
        NotificationsService.cancelNotification(id: int.parse("3${plantCare.id}"));
      }
      break;
      case 3:{
        plantCare.otherName=null;
        plantCare.otherDate=null;
        plantCare.otherTime=null;
        plantCare.otherDate2=null;
        plantCare.otherTime2=null;
        plantCare.otherRepeat=null;
        plantCare.otherRepeat2=null;
        NotificationsService.cancelNotification(id: int.parse("4${plantCare.id}"));
      }
      break;
    }
    notifyListeners();
    await dbHelper.update(plantCare);
    getPlants(arabic: arabic);
  }

  void setTypeOfAlarm({required int index}){
    typeOfAlarm = index;
  }

  void setValues(){
    if(name.text.trim() != ""){
      plantCare.name=name.text;
      switch(typeOfAlarm){
        case 0:{
          plantCare.waterizationDate=date;
          plantCare.waterizationTime=time;
          plantCare.waterizationDate2=date2;
          plantCare.waterizationTime2=time2;
          plantCare.waterizationRepeat=(!repeat)?null:"كل $number $duration";
          plantCare.waterizationRepeat2=(!repeat)?null:"Every $number ${Constants.translate[duration]}";
        }
        break;
        case 1:{
          plantCare.fertilizationDate=date;
          plantCare.fertilizationTime=time;
          plantCare.fertilizationDate2=date2;
          plantCare.fertilizationTime2=time2;
          plantCare.fertilizationRepeat=(!repeat)?null:"كل $number $duration";
          plantCare.fertilizationRepeat2=(!repeat)?null:"Every $number ${Constants.translate[duration]}";
        }
        break;
        case 2:{
          plantCare.harvestDate=date;
          plantCare.harvestTime=time;
          plantCare.harvestDate2=date2;
          plantCare.harvestTime2=time2;
          plantCare.harvestRepeat=(!repeat)?null:"كل $number $duration";
          plantCare.harvestRepeat2=(!repeat)?null:"Every $number ${Constants.translate[duration]}";
        }
        break;
        case 3:{
          plantCare.otherName=typeName;
          plantCare.otherDate=date;
          plantCare.otherTime=time;
          plantCare.otherDate2=date2;
          plantCare.otherTime2=time2;
          plantCare.otherRepeat=(!repeat)?null:"كل $number $duration";
          plantCare.otherRepeat2=(!repeat)?null:"Every $number ${Constants.translate[duration]}";
        }
        break;
      }
    }
  }

  void setNotification({required int id,required bool arabic}){
    String times = 'no',body = "";
    int notificationID = id;
    if(repeat){
      if(durationInt==1&&numberInt==1)
        times = 'daily';
      else if(durationInt==2&&numberInt==1)
        times = 'weekly';
      else if(durationInt==3&&numberInt==1)
        times = 'monthly';
    }
    switch(typeOfAlarm){
      case 0:
        notificationID = int.parse('1$id');
        body = (arabic)?"ري ${plantCare.name}":"${plantCare.name} watering";
        break;
      case 1:
        notificationID = int.parse('2$id');
        body = (arabic)?"تسميد ${plantCare.name}":"${plantCare.name} fertilization";
        break;
      case 2:
        notificationID = int.parse('3$id');
        body = (arabic)?"حصاد ${plantCare.name}":"${plantCare.name} harvest";
        break;
      case 3:
        notificationID = int.parse('4$id');
        String? otherName=(plantCare.otherName==null)?(arabic)?"اخرى":Constants.translate["اخرى"]:plantCare.otherName;
        body = "$otherName ${plantCare.name}";
        break;
    }
    NotificationsService.scheduleNotification(id: notificationID, body: body, time: DateTime(dateTimeSC.year,dateTimeSC.month,dateTimeSC.day,hour,minute),repeat: times);
  }

  Future<void> addAutoPlant({required String uName})async{
    if(uName.trim() != ""){
      PlantCare uPlantCare = PlantCare(name: uName);
      await dbHelper.add(uPlantCare);
    }
  }

  Future<void> addPlant({required bool arabic,required bool home})async{
    if(name.text.trim() != "" && typeOfAlarm!=null){
      setValues();
      int id = await dbHelper.add(plantCare);
      if(img!="")
        await SharedPreferenceHandler.setImg(id: id, img: img);
      setNotification(id: id, arabic: arabic);
      clearValues();
      (home)?getTodayPlants(arabic: arabic):getPlants(arabic: arabic);
    }
  }

  Future<void> getPlantForUpdate({String? image,required bool arabic,required int id}) async{
    img=image??"";
    plantCare = await dbHelper.getPlantDetails(id: id);
    name.text=plantCare.name!;
  }

  void clearValues(){
    name.text="";img="";typeName=null;plantCare=PlantCare(name: "");repeat=false;
  }

  Future<void> updatePlant({required bool arabic,required bool home})async{
    if(name.text.trim() != "" && typeOfAlarm!=null){
      setValues();
      await dbHelper.update(plantCare);
      if(img!="")
        await SharedPreferenceHandler.setImg(id: plantCare.id!, img: img);
      setNotification(id: plantCare.id!, arabic: arabic);
      (home)?getTodayPlants(arabic: arabic):getPlants(arabic: arabic);
    }
  }
}