import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:agrosnap/Componants/ChooseReminderListTile.dart';
import 'package:agrosnap/Componants/CustomCupertinoPicker.dart';
import 'package:agrosnap/Provider/RemindersNotififier.dart';
import 'package:agrosnap/Services/OtherServices.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Reminders extends StatelessWidget{
  bool arabic,update,dark,home;
  int? index;
  Reminders({this.arabic=true,this.update=false,this.index,required this.dark,this.home=false});

  @override
  Widget build(BuildContext context) {
    final reminderNotifier=Provider.of<RemindersNotifier>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: (dark)?Constants.black:null,
        body: Directionality(
          textDirection: (arabic) ? TextDirection.rtl : TextDirection.ltr,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.close,color: (dark)?Constants.primaryColor:Constants.secondaryColor),
                      onPressed: (){
                        reminderNotifier.setDefaultDurationNumber();
                        Navigator.of(context).pop();
                      }
                    ),
                    General.buildTxt(txt: (index!=null)?"إعادة ضبط التذكير":"تذكير جديد",fontSize: 30,color: (dark)?Constants.darkLoop:Constants.gray,pRight: 6,pLeft: 6,pTop: 20),
                    Expanded(child: SizedBox()),
                    IconButton(icon: Icon(Icons.done,color: (dark)?Constants.primaryColor:Constants.secondaryColor),
                      onPressed: () async{
                        (update)? await reminderNotifier.updatePlant(arabic: arabic,home:home) : await reminderNotifier.addPlant(arabic: arabic,home:home);
                        reminderNotifier.setDefaultDurationNumber();
                        Navigator.of(context).pop();
                      }
                    )
                  ],
                ),
                General.sizeBoxVertical(Constants.getScreenHeight(context)*0.016),
                Row(
                  children: [
                    General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.04),
                    Image.asset("Assets/flower.png",color: (dark)?Constants.primaryColor:Constants.gray,height: 26,width: 26),
                    MaterialButton(
                      color: (dark)?Constants.darkBlueLight:Constants.blueGray, textColor: (dark)?Constants.whiteTopGrading:Constants.white, shape: CircleBorder(),
                      child: Selector<RemindersNotifier,String>(
                        selector: (context,remind)=>remind.getImg,
                        builder: (context,img,child){
                          return (img!="")?CircleAvatar(backgroundColor: Constants.primaryColor,radius: 20,
                              backgroundImage: MemoryImage(base64Decode(img))) : Icon(Icons.add_a_photo_outlined,size: 20);
                        },
                      ), padding: EdgeInsets.all(4),height: 30,
                      onPressed: () {
                        General.buildBottomModelSheet(context: context, isEdit: false, arabic: arabic,dark: dark,
                            uploadImage: true,function1: (){reminderNotifier.getImgFromPhone(isCamera: true);},
                            function2: (){reminderNotifier.getImgFromPhone(isCamera: false);});
                      }
                    ),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        controller: reminderNotifier.name,
                        decoration: InputDecoration(
                          hintText: (arabic)?"اسم النبات":"Plant name",
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 20.0, color: (dark)?Constants.whiteTopGrading:Constants.blueGray)
                        ),
                        style: TextStyle(fontSize: 20.0, color: (dark)?Constants.whiteTopGrading:Constants.blueGray),
                        cursorColor: Constants.secondaryColor,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: (arabic)? EdgeInsets.only(right: Constants.getScreenWidth(context)*0.16,left: 10)
                      : EdgeInsets.only(left: Constants.getScreenWidth(context)*0.16,right: 10),
                  child: Divider(thickness: 1.5),
                ),
                ChooseReminderListTile(arabic: arabic,index: index,dark: dark),
                Padding(
                  padding: (arabic)? EdgeInsets.only(right: Constants.getScreenWidth(context)*0.16,left: 10,top:6)
                      : EdgeInsets.only(left: Constants.getScreenWidth(context)*0.16,right: 10,top:6),
                  child: Divider(thickness: 1.5),
                ),
                Selector<RemindersNotifier,String>(
                  selector: (context,dateTime)=>(arabic)?dateTime.getDate:dateTime.getDate2,
                  builder: (context,date,child){
                    return ListTile(
                      leading: Icon(CupertinoIcons.calendar,color: (dark)?Constants.primaryColor:Constants.gray),
                      title: General.buildTxt(txt: date,color: (dark)?Constants.whiteTopGrading:Constants.gray,noTranslate: true),
                      onTap: (){OtherServices.datePicker(context: context,dark:dark);},
                    );
                  },
                ),
                Padding(
                  padding: (arabic)? EdgeInsets.only(right: Constants.getScreenWidth(context)*0.16,left: 10)
                      : EdgeInsets.only(left: Constants.getScreenWidth(context)*0.16,right: 10),
                  child: Divider(thickness: 1.5),
                ),
                Selector<RemindersNotifier,String>(
                  selector: (context,dateTime)=>(arabic)?dateTime.getTime:dateTime.getTime2,
                  builder: (context,time,child){
                    return ListTile(
                      leading: Icon(Icons.access_time,color: (dark)?Constants.primaryColor:Constants.gray),
                      title: General.buildTxt(txt: time,color: (dark)?Constants.whiteTopGrading:Constants.gray,noTranslate: true),
                      onTap: (){OtherServices.timePicker(context: context,dark: dark);},
                    );
                  },
                ),
                Padding(
                  padding: (arabic)? EdgeInsets.only(right: Constants.getScreenWidth(context)*0.16,left: 10)
                      : EdgeInsets.only(left: Constants.getScreenWidth(context)*0.16,right: 10),
                  child: Divider(thickness: 1.5),
                ),
                General.sizeBoxVertical(Constants.getScreenHeight(context)*0.016),
                Row(
                  children: [
                    General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.04),
                    Icon(CupertinoIcons.repeat,color: (dark)?Constants.primaryColor:Constants.gray),
                    General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.07),
                    General.buildTxt(txt: "التكرار",fontSize: 30,color: (dark)?Constants.whiteTopGrading:Constants.gray,isBold: false),
                    Expanded(child: SizedBox()),
                    Selector<RemindersNotifier,bool>(
                      selector: (context,remind)=>remind.getRepeat,
                      builder: (context,repeat,child){
                        return CupertinoSwitch(
                          value: repeat,
                          activeColor: Constants.blueGreen,
                          trackColor: (dark)?Constants.darkGrayLight:Constants.blueLight,
                          onChanged: (inputValue){
                            reminderNotifier.setSwitchValue(value: inputValue);
                          }
                        );
                      }
                    ),
                    General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.02),
                  ],
                ),
                Selector<RemindersNotifier,bool>(
                  selector: (context,remind)=>remind.getRepeat,
                  builder: (context,repeat,child)=>(repeat)?CustomCupertinoPicker(dark: dark):General.sizeBoxVertical(0.0),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}