import 'package:agrosnap/Componants/ResetReminderContainer.dart';
import 'package:agrosnap/Componants/RoundedButton.dart';
import 'package:agrosnap/Provider/RemindersNotififier.dart';
import 'package:agrosnap/Screens/Garden/Reminders.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetReminders extends StatelessWidget{
  bool arabic,dark,home;
  ResetReminders({this.arabic=true,required this.dark,this.home=false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
          onWillPop: () async{
            Provider.of<RemindersNotifier>(context,listen: false).clearValues();
            return true;
          },
          child: Scaffold(
            backgroundColor: (dark)?Constants.black:null,
            body: Directionality(
              textDirection: (arabic)? TextDirection.rtl : TextDirection.ltr,
              child: SingleChildScrollView(
                child: Consumer<RemindersNotifier>(
                  builder: (context,plantCare,child){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(icon: Icon(Icons.close,color: (dark)?Constants.primaryColor:Constants.secondaryColor),
                              onPressed: (){
                                Provider.of<RemindersNotifier>(context,listen: false).clearValues();
                                Navigator.of(context).pop();
                              }
                            ),
                            General.buildTxt(txt: "إعادة ضبط التذكير",fontSize: 30,color: (dark)?Constants.darkLoop:Constants.gray,pRight: 6,pLeft: 6,pTop: 20),
                          ],
                        ),
                        General.sizeBoxVertical(Constants.getScreenHeight(context)*0.016),

                        (plantCare.plantCare.waterizationDate==null&&plantCare.plantCare.waterizationDate2==null) ? General.sizeBoxVertical(0.0)
                            : ResetReminderContainer(img: Icon(CupertinoIcons.drop,color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,size: 30),dark: dark,
                            title: "ري النبات", date: (arabic)?plantCare.plantCare.waterizationDate!:plantCare.plantCare.waterizationDate2!,
                            time: (arabic)?plantCare.plantCare.waterizationTime!:plantCare.plantCare.waterizationTime2!, arabic: arabic,index: 0,
                            repeat: (arabic)?plantCare.plantCare.waterizationRepeat??"":plantCare.plantCare.waterizationRepeat2??"",home: home),

                        (plantCare.plantCare.fertilizationDate==null&&plantCare.plantCare.fertilizationDate2==null) ? General.sizeBoxVertical(0.0)
                            : ResetReminderContainer(img: Image.asset("Assets/seed.png",color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,height: 30,width: 30),dark: dark,
                            title: "تسميد النبات", date: (arabic)?plantCare.plantCare.fertilizationDate!:plantCare.plantCare.fertilizationDate2!,
                            time: (arabic)?plantCare.plantCare.fertilizationTime!:plantCare.plantCare.fertilizationTime2!,arabic: arabic,index: 1,
                            repeat: (arabic)?plantCare.plantCare.fertilizationRepeat??"":plantCare.plantCare.fertilizationRepeat2??"",home: home),

                        (plantCare.plantCare.harvestDate==null&&plantCare.plantCare.harvestDate2==null) ? General.sizeBoxVertical(0.0)
                            : ResetReminderContainer(img: Image.asset("Assets/harvest.png",color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,height: 36,width: 36),
                            title: "حصاد النبات", date: (arabic)?plantCare.plantCare.harvestDate!:plantCare.plantCare.harvestDate2!,dark: dark,
                            time: (arabic)?plantCare.plantCare.harvestTime!:plantCare.plantCare.harvestTime2!,arabic: arabic,index: 2,
                            repeat: (arabic)?plantCare.plantCare.harvestRepeat??"":plantCare.plantCare.harvestRepeat2??"",home: home),

                        (plantCare.plantCare.otherDate==null&&plantCare.plantCare.otherDate2==null) ? General.sizeBoxVertical(0.0)
                            : ResetReminderContainer(img: Icon(CupertinoIcons.bell,color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,size: 30),
                            date: (arabic)?plantCare.plantCare.otherDate!:plantCare.plantCare.otherDate2!,dark: dark,
                            time: (arabic)?plantCare.plantCare.otherTime!:plantCare.plantCare.otherTime2!,
                            title: plantCare.plantCare.otherName,arabic: arabic,index: 3,home: home,
                            repeat: (arabic)?plantCare.plantCare.otherRepeat??"":plantCare.plantCare.otherRepeat2??""),

                        General.sizeBoxVertical(Constants.getScreenHeight(context)*0.016),
                        Center(child: RoundedButton(color: (dark)?Constants.darkOrange:Constants.orange, txt: "إضافة تذكير جديد",
                            horizontalPadding: 0.1,width: 0.6, function: (){
                              Provider.of<RemindersNotifier>(context,listen: false).setDateTimeNow();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Reminders(arabic: arabic,update: true,dark: dark,home:home)));
                            })
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        )
    );
  }
}