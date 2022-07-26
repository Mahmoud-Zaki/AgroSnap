import 'package:agrosnap/Provider/RemindersNotififier.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseReminderListTile extends StatefulWidget{
  bool arabic,dark;
  int? index;
  ChooseReminderListTile({this.arabic=true,this.index,required this.dark});

  @override
  ChooseReminderListTileState createState()=>ChooseReminderListTileState();
}

class ChooseReminderListTileState extends State<ChooseReminderListTile>{
  Color? backgroundColor = Constants.blueLight;
  List<Color> backgroundContainerColor = [Colors.transparent,Colors.transparent,Colors.transparent,Colors.transparent];
  List<String> txt = ["الري","التسميد","الحصاد","اخرى"];
  Widget icon = Icon(CupertinoIcons.bell,color: Constants.gray);
  bool showBorder = false, readOnly=true;
  String hintText = "";

  @override
  void initState() {
    super.initState();
    backgroundColor = (widget.dark)?Constants.darkBlueLight:Constants.blueLight;
    icon = Icon(CupertinoIcons.bell,color: (widget.dark)?Constants.primaryColor:Constants.gray);
    if(widget.index!=null){
      backgroundContainerColor[widget.index!]=(widget.dark)?Constants.primaryColor:Constants.loopColor;
      showBorder=true;
      backgroundColor=Colors.transparent;
      if(widget.index==0){
        readOnly=true;
        hintText=txt[widget.index!];
        icon = Icon(CupertinoIcons.drop,color: (widget.dark)?Constants.primaryColor:Constants.gray);
      }
      else if(widget.index==1){
        readOnly=true;
        hintText=txt[widget.index!];
        icon = Image.asset("Assets/seed.png",color: (widget.dark)?Constants.primaryColor:Constants.gray,width: 24,height: 24);
      }
      else if(widget.index==2){
        readOnly=true;
        hintText=txt[widget.index!];
        icon = Image.asset("Assets/harvest.png",color: (widget.dark)?Constants.primaryColor:Constants.gray,width: 32,height: 32);
      }
      else{
        hintText=Provider.of<RemindersNotifier>(context,listen: false).plantCare.otherName??"";
        readOnly=false;
        icon = Icon(CupertinoIcons.bell,color: (widget.dark)?Constants.primaryColor:Constants.gray);
      }
      Provider.of<RemindersNotifier>(context,listen: false).setTypeOfAlarm(index: widget.index!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          ListTile(
            leading: icon,
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: Constants.getScreenWidth(context)*0.02),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(40.0),
                  border: (showBorder)?Border.all(color: (widget.dark)?Constants.primaryColor:Constants.loopColor):null,
              ),
              child: TextField(
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: (widget.arabic)?"ذكرني ب" + hintText : "Remind me of" + Constants.translate[hintText].toString(),
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: (widget.dark)?Constants.whiteTopGrading:null,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20.0,
                  color: (widget.dark)?Constants.whiteTopGrading:Constants.blueGray,
                ),
                cursorColor: Constants.secondaryColor,
                readOnly: readOnly,
                onChanged: (String? input){Provider.of<RemindersNotifier>(context,listen: false).typeName=input;},
              ),
            ),
          ),
          SizedBox(
            width: Constants.getScreenWidth(context),
            height: Constants.getScreenHeight(context)*0.046,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              padding: (widget.arabic)? EdgeInsets.only(right: 30,top: Constants.getScreenHeight(context)*0.006)
                  : EdgeInsets.only(left: 30,top: Constants.getScreenHeight(context)*0.006),
              itemBuilder: (BuildContext context,int index){
                return InkWell(
                  child: Container(
                    width: Constants.getScreenWidth(context)*0.24,
                    margin: (widget.arabic)?const EdgeInsets.only(left: 10):const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: backgroundContainerColor[index],
                      borderRadius: BorderRadius.circular(40.0),
                      border: Border.all(color: (widget.dark)?Constants.primaryColor:Constants.loopColor),
                    ),
                    child: Center(child: General.buildTxt(txt: txt[index],isBold: false,fontSize: 24,color: (widget.dark)?Constants.whiteTopGrading:Constants.gray)),
                  ),
                  onTap: (){
                    if(widget.index==null){
                      setState(() {
                        backgroundContainerColor=[Colors.transparent,Colors.transparent,Colors.transparent,Colors.transparent];
                        backgroundContainerColor[index]=(widget.dark)?Constants.primaryColor:Constants.loopColor;
                        showBorder=true;
                        backgroundColor=Colors.transparent;
                        if(index==0){
                          readOnly=true;
                          hintText=txt[index];
                          icon = Icon(CupertinoIcons.drop,color: (widget.dark)?Constants.primaryColor:Constants.gray);
                        }
                        else if(index==1){
                          readOnly=true;
                          hintText=txt[index];
                          icon = Image.asset("Assets/seed.png",color: (widget.dark)?Constants.primaryColor:Constants.gray,width: 24,height: 24);
                        }
                        else if(index==2){
                          readOnly=true;
                          hintText=txt[index];
                          icon = Image.asset("Assets/harvest.png",color: (widget.dark)?Constants.primaryColor:Constants.gray,width: 32,height: 32);
                        }
                        else{
                          hintText="";
                          readOnly=false;
                          icon = Icon(CupertinoIcons.bell,color: (widget.dark)?Constants.primaryColor:Constants.gray);
                        }
                        Provider.of<RemindersNotifier>(context,listen: false).setTypeOfAlarm(index: index);
                      });
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}