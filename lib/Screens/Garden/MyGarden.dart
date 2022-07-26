import 'package:agrosnap/Componants/CommonTopOfScreen.dart';
import 'package:agrosnap/Componants/ReminderContainer.dart';
import 'package:agrosnap/Componants/RoundedButton.dart';
import 'package:agrosnap/Provider/RemindersNotififier.dart';
import 'package:agrosnap/Provider/SettingNotifier.dart';
import 'package:agrosnap/Screens/Garden/Reminders.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyGarden extends StatefulWidget{
  @override
  _MyGardenState createState() => _MyGardenState();
}

class _MyGardenState extends State<MyGarden> {

  @override
  void initState() {
    super.initState();
    bool arabic = Provider.of<SettingNotifier>(context,listen: false).getArLanguage;
    Provider.of<RemindersNotifier>(context,listen: false).getPlants(arabic: arabic);
  }

  @override
  Widget build(BuildContext context) {
    var setting = Provider.of<SettingNotifier>(context,listen: false);
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: CommonTopOfScreen(
            img: "Assets/wheat.png",txt: "التذكير برعاية النبات",
            height: Constants.getScreenHeight(context)*0.14,
          ),
        ),
        Container(
          height: Constants.getScreenHeight(context)*0.84,
          padding: EdgeInsets.symmetric(horizontal: Constants.getScreenWidth(context)*0.001),
          margin: EdgeInsets.only(top: Constants.getScreenHeight(context)*0.11),
          decoration: BoxDecoration(
            color: (setting.dark)?Constants.black:Constants.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0),
              topLeft: Radius.circular(40.0),
            ),
          ),
          child: Consumer<RemindersNotifier>(
            builder: (context,plants,child){
              if(plants.plantsCare.isEmpty)
                return SizedBox(
                  width: Constants.getScreenWidth(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      General.buildTxt(txt: "لا يوجد تذكير",fontSize: 20,color: (setting.dark)?Constants.white:Constants.grayLight),
                      General.sizeBoxVertical(Constants.getScreenHeight(context)*0.016),
                      RoundedButton(color: (setting.dark)?Constants.darkOrange:Constants.orange, txt: "إضافة تذكير جديد", horizontalPadding: 0.1,width: 0.6,
                        function: (){
                          Provider.of<RemindersNotifier>(context,listen: false).clearValues();
                          Provider.of<RemindersNotifier>(context,listen: false).setDateTimeNow();
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>Reminders(arabic: setting.getArLanguage,dark: setting.dark)));
                        }
                      )
                    ],
                  ),
                );
              else
                return Stack(
                  children: [
                    SizedBox(
                      width: Constants.getScreenWidth(context),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: plants.plantsCare.length,padding: EdgeInsets.only(top: Constants.getScreenHeight(context)*0.02),
                        itemBuilder: (BuildContext context, int index){
                          return ReminderContainer(plantCare: plants.plantsCare[index],home: false,
                              arabic: setting.getArLanguage,dark: setting.dark,listIndex: index);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,bottom: 16),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          child: Icon(Icons.add,size: 46),
                          backgroundColor: (setting.dark)?Constants.darkOrange:Constants.orange,
                          onPressed: (){
                            Provider.of<RemindersNotifier>(context,listen: false).clearValues();
                            Provider.of<RemindersNotifier>(context,listen: false).setDateTimeNow();
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>Reminders(arabic: setting.getArLanguage,dark: setting.dark)));
                            },
                        ),
                      ),
                    ),
                  ],
                );
            },
          )
        ),
      ],
    );
  }
}