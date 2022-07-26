import 'dart:convert';
import 'package:agrosnap/Models/PlantCare.dart';
import 'package:agrosnap/Provider/RemindersNotififier.dart';
import 'package:agrosnap/Screens/Garden/ResetReminders.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReminderContainer extends StatelessWidget {
  bool arabic,home,dark;
  PlantCare plantCare;
  int listIndex;
  static const List<String> choices = <String>["إعادة ضبط التذكير", "حذف النبات"];
  ReminderContainer({required this.plantCare,this.arabic=true,
    required this.listIndex,required this.home,required this.dark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (!home)?EdgeInsets.only(bottom: 20,left: 16,right: 16):EdgeInsets.only(bottom: 12,left: 10,right: 10),
      decoration: BoxDecoration(
        color: (dark)?Constants.darkBlueLight:Constants.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Constants.blueGray.withOpacity(0.5),
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Directionality(
        textDirection: (arabic)?TextDirection.rtl:TextDirection.ltr,
        child: ListTile(
          leading: (plantCare.img!=null) ?
          CircleAvatar(backgroundColor: Constants.primaryColor,radius: (!home)?26:20,backgroundImage: MemoryImage(base64Decode(plantCare.img!))):null,
          title: General.buildTxt(txt: plantCare.name!,color: (dark)?Constants.white:Constants.primaryColor,noTranslate: true,fontSize: (!home)?30:24),
          subtitle: Column(
            children: [
              General.sizeBoxVertical((!home)?6.0:3.0),
              (plantCare.waterizationDate!=null||plantCare.waterizationDate2!=null||plantCare.waterizationTime!=null||plantCare.waterizationTime2!=null)?Row(
                children: [
                  Icon(CupertinoIcons.drop,color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,size: (home)?18:null),
                  General.sizeBoxHorizontal(10.0),
                  General.buildTxt(txt: "ري النبات",color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,isBold: false,fontSize: (!home)?20:18),
                  Expanded(child: SizedBox()),
                  General.buildTxt(txt: (arabic)?(home)?plantCare.waterizationTime??"":plantCare.waterizationDate??"":(home)?plantCare.waterizationTime2??"":plantCare.waterizationDate2??"",
                      noTranslate: true,color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,isBold: false,fontSize: (!home)?18:16),
                ],
              )
                  : General.sizeBoxVertical(0.0),
              (plantCare.waterizationDate!=null||plantCare.waterizationDate2!=null||plantCare.waterizationTime!=null||plantCare.waterizationTime2!=null)?
              General.sizeBoxVertical((!home)?6.0:3.0):General.sizeBoxVertical(0.0),
              (plantCare.fertilizationDate!=null||plantCare.fertilizationDate2!=null||plantCare.fertilizationTime!=null||plantCare.fertilizationTime2!=null)?Row(
                children: [
                  Image.asset("Assets/seed.png",color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,width: (!home)?20:14,height: (!home)?20:14),
                  General.sizeBoxHorizontal(10.0),
                  General.buildTxt(txt: "تسميد النبات",color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,isBold: false,fontSize: (!home)?20:18),
                  Expanded(child: SizedBox()),
                  General.buildTxt(txt: (arabic)?(home)?plantCare.fertilizationTime??"":plantCare.fertilizationDate??"":(home)?plantCare.fertilizationTime2??"":plantCare.fertilizationDate2??"",
                      noTranslate: true,color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,isBold: false,fontSize: (!home)?18:16),
                ],
              )
                  : General.sizeBoxVertical(0.0),
              (plantCare.fertilizationDate!=null||plantCare.fertilizationDate2!=null||plantCare.fertilizationTime!=null||plantCare.fertilizationTime2!=null)?
              General.sizeBoxVertical((!home)?6.0:3.0):General.sizeBoxVertical(0.0),
              (plantCare.harvestDate!=null||plantCare.harvestDate2!=null||plantCare.harvestTime!=null||plantCare.harvestTime2!=null)?Row(
                children: [
                  Image.asset("Assets/harvest.png",color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,width: (!home)?26:20,height: (!home)?26:20),
                  General.sizeBoxHorizontal(10.0),
                  General.buildTxt(txt: "حصاد النبات",color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,isBold: false,fontSize: (!home)?20:18),
                  Expanded(child: SizedBox()),
                  General.buildTxt(txt: (arabic)?(home)?plantCare.harvestTime??"":plantCare.harvestDate??"":(home)?plantCare.harvestTime2??"":plantCare.harvestDate2??"",
                      noTranslate: true,color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,isBold: false,fontSize: (!home)?18:16),
                ],
              )
                  : General.sizeBoxVertical(0.0),
              (plantCare.harvestDate!=null||plantCare.harvestDate2!=null||plantCare.harvestTime!=null||plantCare.harvestTime2!=null)?
              General.sizeBoxVertical((!home)?6.0:3.0):General.sizeBoxVertical(0.0),
              (plantCare.otherDate!=null||plantCare.otherDate2!=null||plantCare.otherTime!=null||plantCare.otherTime2!=null)?Row(
                children: [
                  Icon(CupertinoIcons.bell,color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,size: (home)?18:null),
                  General.sizeBoxHorizontal(10.0),
                  Flexible(child: General.buildTxt(txt: plantCare.otherName??"اخرى",color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,isBold: false,
                      noTranslate: (plantCare.otherName!=null)?true:false,fontSize: (!home)?20:18)),
                  Expanded(child: SizedBox()),
                  General.buildTxt(txt: (arabic)?(home)?plantCare.otherTime??"":plantCare.otherDate??"":(home)?plantCare.otherTime2??"":plantCare.otherDate2??"",
                      noTranslate: true,color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,isBold: false,fontSize:(!home)?18:16),
                ],
              )
                  : General.sizeBoxVertical(0.0),
              (plantCare.otherDate!=null||plantCare.otherDate2!=null||plantCare.otherTime!=null||plantCare.otherTime2!=null)?
              General.sizeBoxVertical((!home)?6.0:3.0):General.sizeBoxVertical(0.0),
            ],
          ),
          trailing: PopupMenuButton<String>(
            color: (dark)?Constants.darkBlueLight:null,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            elevation: 10.0,
            icon: Icon(Icons.more_vert,color: Constants.grayLight),
            onSelected: (String choice) async{
              if(choice==choices[0]){
                await Provider.of<RemindersNotifier>(context,listen: false)
                    .getPlantForUpdate(image: plantCare.img,arabic: arabic,id: plantCare.id!);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>ResetReminders(arabic: arabic,dark: dark,home:home)));
              }
              else if(choice==choices[1])
                Provider.of<RemindersNotifier>(context,listen: false)
                    .deletePlant(id: plantCare.id!, listIndex: listIndex);
            },
            itemBuilder: (BuildContext context){
              return choices.map((String choice){
                return PopupMenuItem<String>(
                    value: choice,
                    child: General.buildTxt(txt: choice,color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,isBold: false)
                );
              }).toList();
            },
          ),
        )
      ),
    );
  }
}