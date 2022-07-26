import 'package:agrosnap/Componants/PrimaryContainer.dart';
import 'package:agrosnap/Provider/SearchNotifier.dart';
import 'package:agrosnap/Provider/SettingNotifier.dart';
import 'package:agrosnap/Screens/Plant/Plant.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var notify= Provider.of<SettingNotifier>(context,listen: false);
    return Container(
      child: Center(
        child: Consumer<SearchNotifier>(
          builder: (context,img,child){
            if(img.notFound)
              return General.buildTxt(txt: "Not Found",fontSize: 20,color: (notify.dark)?Constants.white:Constants.grayLight);
            else if(img.loading)
              return General.customLoading(color: (notify.dark)?Constants.darkLoop:
              Constants.primaryColor,doubleBounce: true);
            else
              return SizedBox(
                height: Constants.getScreenHeight(context) * 0.26,
                child: PrimaryContainer(title: (img.disease)?img.plant["اسم المرض"]??"":img.plant["الاسم"]??"", img: (img.disease)?img.plant["صورة"]??"":img.plant["الصورة"]??"",
                    titleColor: (notify.dark)?Constants.whiteTopGrading:Constants.gray,
                    recommended: true,dark: notify.dark,
                    function: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Plant(arabic: notify.getArLanguage,name: (img.disease)?img.plant["اسم المرض"]??"":img.plant["الاسم"]??"",
                              dark: notify.dark,disease: (img.mType=="d"),recommend: true)));
                    }),
              );
          },
        )
      ),
    );
  }
}