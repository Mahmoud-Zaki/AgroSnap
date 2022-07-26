import 'package:agrosnap/Provider/RemindersNotififier.dart';
import 'package:agrosnap/Screens/Garden/Reminders.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetReminderContainer extends StatelessWidget{
  bool arabic,dark,home;
  String? title;
  String date,time,repeat;
  Widget img;
  int index;
  ResetReminderContainer({required this.img,required this.title,required this.date,required this.dark,
    required this.time, required this.index, this.arabic=true,required this.repeat,this.home=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(bottom: Constants.getScreenHeight(context)*0.016,
            left: Constants.getScreenWidth(context)*0.016,right: Constants.getScreenWidth(context)*0.016),
        decoration: BoxDecoration(
          color: (dark)?Constants.darkBlueLight:Constants.whiteTopGrading,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Directionality(
            textDirection: (arabic)?TextDirection.rtl:TextDirection.ltr,
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: img,
                    title: General.buildTxt(txt: (index==3&&title==null)?"اخرى":title!,color: (dark)?Constants.white:Constants.primaryColor,
                        fontSize: 26,noTranslate: (index==3&&title==null)?false:(index==3)?true:false),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        General.buildTxt(txt: (arabic)?"$date عند $time":"$date at $time",
                            color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,fontSize: 18,isBold: false,noTranslate: true),
                        (repeat=="")?General.sizeBoxVertical(0.0):General.sizeBoxVertical(6.0),
                        (repeat=="")?General.sizeBoxVertical(0.0)
                            : General.buildTxt(txt: repeat, color: (dark)?Constants.whiteTopGrading:Constants.primaryColor,
                            fontSize: 18,isBold: false,noTranslate: true),
                      ],
                    )
                  ),
                ),
                SizedBox(child: Image.asset("Assets/wheat.png"))
              ],
            ),
        ),
      ),
      onTap: (){
        if(arabic){
          Provider.of<RemindersNotifier>(context,listen: false).date=date;
          Provider.of<RemindersNotifier>(context,listen: false).time=time;
        }
        else{
          Provider.of<RemindersNotifier>(context,listen: false).date2=date;
          Provider.of<RemindersNotifier>(context,listen: false).time2=time;
        }
        Provider.of<RemindersNotifier>(context,listen: false).setSwitchValue(value: (repeat=="")?false:true);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            Reminders(arabic: arabic,update: true,index: index,dark: dark,home: home)));
      },
      onLongPress: (){
        General.buildDialog(context: context, title: "حذف تذكير",actionText: "حذف",dark: dark,
          content: General.buildTxt(txt: "هل تريد حذف التذكير؟",isBold: false,fontSize: 24.0,color: (dark)?Constants.grayLight:Constants.gray),
          function: (){
            Provider.of<RemindersNotifier>(context,listen: false).deleteType(index: index, arabic: arabic);
            General.buildToast(msg: (arabic)?"تم الحذف بنجاح":"Deleted Successfully",dark: dark);
          }
        );
      },
    );
  }
}