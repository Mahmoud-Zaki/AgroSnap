import 'package:agrosnap/Provider/SettingNotifier.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommonTopOfScreen extends StatelessWidget{
  String img;
  String txt;
  double height;
  CommonTopOfScreen({required this.img,required this.height,this.txt=""});

  @override
  Widget build(BuildContext context) {
    var setting = Provider.of<SettingNotifier>(context,listen: false);
    return (txt!="")?Container(
        height: height,width: Constants.getScreenWidth(context),
        padding: EdgeInsets.only(
          left: Constants.getScreenWidth(context)*0.05,
          right: Constants.getScreenWidth(context)*0.05,
          bottom: Constants.getScreenHeight(context)*0.04
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            alignment: (setting.getArLanguage)?Alignment.topLeft:Alignment.topRight
          ),
          gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                (setting.dark)?Color(0xffB5C8CE):Constants.whiteTopGrading,
                (setting.dark)?Color(0xffA8B1B4):Constants.white
              ]
          ),
        ),
        child: Row(
          children: [
            General.buildTxt(txt: txt, color: Constants.primaryColor,fontSize: 30),
            Expanded(child: SizedBox(),flex: 1,)
          ],
        )
    ):Container(
        height: height,
        padding: EdgeInsets.only(left: Constants.getScreenWidth(context)*0.1),
        alignment: Alignment.centerLeft,
        child: Image.asset(img)
    );
  }
}