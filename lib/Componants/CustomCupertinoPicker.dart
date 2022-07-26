import 'package:agrosnap/Provider/RemindersNotififier.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCupertinoPicker extends StatelessWidget{
  bool dark;
  CustomCupertinoPicker({required this.dark});

  List<int> numbers = [1,2,3,4,5,6,7,8,9,10];
  List<String> duration = ["يوم","أسبوع","شهر","سنة"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.getScreenHeight(context)*0.2,
      margin: EdgeInsets.symmetric(vertical: Constants.getScreenHeight(context)*0.02,
          horizontal: Constants.getScreenWidth(context)*0.02),
      decoration: BoxDecoration(
        color: (dark)?Constants.darkBlueLight:Constants.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Constants.blueGray.withOpacity(0.5),
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CupertinoPicker(
              children: [General.buildTxt(txt: "كل",color: (dark)?Constants.whiteTopGrading:Constants.gray)],
              onSelectedItemChanged: (_){},
              itemExtent: 25,
              diameterRatio:1,
              useMagnifier: true,
              magnification: 1.2,
            )
          ),
          Expanded(
            child: CupertinoPicker(
              children: [
                General.buildTxt(txt: numbers[0].toString(),color: (dark)?Constants.whiteTopGrading:Constants.gray,noTranslate: true),
                General.buildTxt(txt: numbers[1].toString(),color: (dark)?Constants.whiteTopGrading:Constants.gray,noTranslate: true),
                General.buildTxt(txt: numbers[2].toString(),color: (dark)?Constants.whiteTopGrading:Constants.gray,noTranslate: true),
                General.buildTxt(txt: numbers[3].toString(),color: (dark)?Constants.whiteTopGrading:Constants.gray,noTranslate: true),
                General.buildTxt(txt: numbers[4].toString(),color: (dark)?Constants.whiteTopGrading:Constants.gray,noTranslate: true),
                General.buildTxt(txt: numbers[5].toString(),color: (dark)?Constants.whiteTopGrading:Constants.gray,noTranslate: true),
                General.buildTxt(txt: numbers[6].toString(),color: (dark)?Constants.whiteTopGrading:Constants.gray,noTranslate: true),
                General.buildTxt(txt: numbers[7].toString(),color: (dark)?Constants.whiteTopGrading:Constants.gray,noTranslate: true),
                General.buildTxt(txt: numbers[8].toString(),color: (dark)?Constants.whiteTopGrading:Constants.gray,noTranslate: true),
                General.buildTxt(txt: numbers[9].toString(),color: (dark)?Constants.whiteTopGrading:Constants.gray,noTranslate: true),
              ],
              onSelectedItemChanged: (value){
                Provider.of<RemindersNotifier>(context,listen: false).setNumber(value: numbers[value]);
              },
              itemExtent: 25,
              diameterRatio:1,
              useMagnifier: true,
              looping: true,
              magnification: 1.2,
            )
          ),
          Expanded(
            child: CupertinoPicker(
              children: [
                General.buildTxt(txt: duration[0],color: (dark)?Constants.whiteTopGrading:Constants.gray),
                General.buildTxt(txt: duration[1],color: (dark)?Constants.whiteTopGrading:Constants.gray),
                General.buildTxt(txt: duration[2],color: (dark)?Constants.whiteTopGrading:Constants.gray),
                General.buildTxt(txt: duration[3],color: (dark)?Constants.whiteTopGrading:Constants.gray),
              ],
              onSelectedItemChanged: (value){
                Provider.of<RemindersNotifier>(context,listen: false).setDuration(value: duration[value],index:value);
              },
              itemExtent: 25,
              diameterRatio:1,
              useMagnifier: true,
              magnification: 1.2,
              looping: true,
            )
          ),
        ],
      )
    );
  }
}