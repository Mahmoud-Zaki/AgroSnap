import 'package:agrosnap/Componants/CommonTopOfScreen.dart';
import 'package:agrosnap/Provider/SettingNotifier.dart';
import 'package:agrosnap/Services/SharedPreference.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class Setting extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: CommonTopOfScreen(
            img: "Assets/wheat.png",txt: "الإعدادات",
            height: Constants.getScreenHeight(context)*0.14,
          ),
        ),
        Consumer<SettingNotifier>(
          builder: (context,setting,child)=> Container(
            padding: EdgeInsets.only(
              left: Constants.getScreenWidth(context)*0.06,
              right: Constants.getScreenWidth(context)*0.03,
              top: Constants.getScreenHeight(context)*0.05
            ),
            margin: EdgeInsets.only(top: Constants.getScreenHeight(context)*0.11),
            decoration: BoxDecoration(
              color: (setting.dark)?Constants.black:Constants.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.dark_mode,size: 36,color: (setting.dark)?Constants.darkLoop:Constants.grayLight),
                    General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.03),
                    General.buildTxt(txt: "الوضع الليلي",fontSize: 24,color: (setting.dark)?Constants.white:Constants.primaryColor),
                    Expanded(child: SizedBox()),
                    CupertinoSwitch(
                        value: setting.dark,
                        activeColor: Constants.darkLoop,
                        trackColor: Constants.blueLight,
                        onChanged: (inputValue){
                          setting.setDarkMode(value: inputValue);
                          SharedPreferenceHandler.setMode(value: inputValue);
                        }
                    )
                  ],
                ),
                General.sizeBoxVertical(Constants.getScreenHeight(context)*0.05),
                InkWell(
                  child: Row(
                    children: [
                      Icon(Icons.format_size,size: 36,color: (setting.dark)?Constants.darkLoop:Constants.grayLight),
                      General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.03),
                      General.buildTxt(txt: "حجم الخط",fontSize: 24,color: (setting.dark)?Constants.white:Constants.primaryColor),
                    ],
                  ),
                  onTap: setting.openSize,
                ),
                (setting.appearSize) ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constants.getScreenWidth(context)*0.1),
                  child: Row(
                    children: [
                      Theme(
                        data: ThemeData(unselectedWidgetColor: (setting.dark)?Constants.darkGrayLight:null),
                        child: Radio(
                          value: 0,
                          activeColor: (setting.dark)?Constants.darkLoop:Constants.primaryColor,
                          groupValue: setting.groupSizeValue,
                          onChanged: (value){
                            setting.setFontSize(value: value);
                            SharedPreferenceHandler.setFontSize(value: value);
                          },
                        ),
                      ),
                      General.buildTxt(txt: "عادي",isBold: false,color: (setting.dark)?Constants.whiteTopGrading:Constants.secondaryColor)
                    ],
                  ),
                ) : General.sizeBoxVertical(Constants.getScreenHeight(context)*0.025),
                (setting.appearSize) ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constants.getScreenWidth(context)*0.1),
                  child: Row(
                    children: [
                      Theme(
                        data: ThemeData(unselectedWidgetColor: (setting.dark)?Constants.darkGrayLight:null),
                        child: Radio(
                          value: 1,
                          activeColor: (setting.dark)?Constants.darkLoop:Constants.primaryColor,
                          groupValue: setting.groupSizeValue,
                          onChanged: (value){
                            setting.setFontSize(value: value);
                            SharedPreferenceHandler.setFontSize(value: value);
                          },
                        ),
                      ),
                      General.buildTxt(txt: "كبير",isBold: false,color: (setting.dark)?Constants.whiteTopGrading:Constants.secondaryColor)
                    ],
                  ),
                ) : General.sizeBoxVertical(Constants.getScreenHeight(context)*0.025),
                InkWell(
                  child: Row(
                    children: [
                      Icon(Icons.translate,size: 36,color: (setting.dark)?Constants.darkLoop:Constants.grayLight),
                      General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.03),
                      General.buildTxt(txt: "اللغة",fontSize: 24,color: (setting.dark)?Constants.white:Constants.primaryColor),
                    ],
                  ),
                  onTap: setting.openLanguage,
                ),
                (setting.appearLanguage) ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constants.getScreenWidth(context)*0.1),
                  child: Row(
                    children: [
                      Theme(
                        data: ThemeData(unselectedWidgetColor: (setting.dark)?Constants.darkGrayLight:null),
                        child: Radio(
                          value: 2,
                          activeColor: (setting.dark)?Constants.darkLoop:Constants.primaryColor,
                          groupValue: setting.groupLanguageValue,
                          onChanged: (value){
                            setting.setLanguage(value: value);
                            SharedPreferenceHandler.setLanguage(value: value);
                          },
                        ),
                      ),
                      General.buildTxt(txt: "ع",isBold: false,color: (setting.dark)?Constants.white:Constants.secondaryColor)
                    ],
                  ),
                ) : General.sizeBoxVertical(Constants.getScreenHeight(context)*0.025),
                (setting.appearLanguage) ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constants.getScreenWidth(context)*0.1),
                  child: Row(
                    children: [
                      Theme(
                        data: ThemeData(unselectedWidgetColor: (setting.dark)?Constants.darkGrayLight:null),
                        child: Radio(
                          value: 3,
                          activeColor: (setting.dark)?Constants.darkLoop:Constants.primaryColor,
                          groupValue: setting.groupLanguageValue,
                          onChanged: (value){
                            setting.setLanguage(value: value);
                            SharedPreferenceHandler.setLanguage(value: value);
                          },
                        ),
                      ),
                      General.buildTxt(txt: "En",isBold: false,color: (setting.dark)?Constants.whiteTopGrading:Constants.secondaryColor)
                    ],
                  ),
                ) : General.sizeBoxVertical(Constants.getScreenHeight(context)*0.025),
                InkWell(
                  child: Row(
                    children: [
                      Icon(Icons.share,size: 36,color: (setting.dark)?Constants.darkLoop:Constants.grayLight),
                      General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.03),
                      General.buildTxt(txt: "مشاركة التطبيق",fontSize: 24,color: (setting.dark)?Constants.white:Constants.primaryColor),
                    ],
                  ),
                  onTap: () async{
                    final RenderBox box = context.findRenderObject() as RenderBox;
                    await Share.share(
                        "https://play.google.com/store/apps/details?id=com.zaki.agrosnap",
                        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,subject: "AgroSnap"
                    );
                  },
                ),
              ],
            )
          ),
        ),
      ],
    );
  }
}