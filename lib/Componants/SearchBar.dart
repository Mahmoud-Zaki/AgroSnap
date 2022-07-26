import 'package:agrosnap/Provider/SettingNotifier.dart';
import 'package:agrosnap/Screens/Search/SearchByName.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget{
  bool readOnly, map,dark;
  String txt;
  Function function;
  SearchBar({required this.txt,required this.readOnly,
    required this.function,this.map = false,this.dark = false});

  @override
  Widget build(BuildContext context) {
    var setting = Provider.of<SettingNotifier>(context,listen: false);
    return Container(
      width: (map)?Constants.getScreenWidth(context)*0.9:null,
      margin: (map)?EdgeInsets.symmetric(horizontal: Constants.getScreenWidth(context)*0.05):null,
      decoration: BoxDecoration(
        color: (dark)?Constants.darkBlueLight:Constants.white,
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(
            color: Constants.blueGray.withOpacity(0.5),
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: InputDecoration(
          hintText: (setting.getArLanguage)?txt:Constants.translate[txt].toString(),
          hintStyle: TextStyle(
            fontSize: (setting.largeFontSize) ? 20.0 : 15.0,
            color: (dark)?Constants.whiteTopGrading:Constants.blueGray,
          ),
          prefixIcon: Icon(CupertinoIcons.search,color: Constants.grayLight,size: 30),
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: (setting.largeFontSize) ? 20.0 : 15.0,
          color: (dark)?Constants.blueLight:Constants.blueGray,
        ),
        readOnly: readOnly,
        cursorColor: Constants.secondaryColor,
        textInputAction: TextInputAction.done,
        onTap:(!readOnly) ? null : () {
          bool arabic= Provider.of<SettingNotifier>(context,listen: false).getArLanguage;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchByName(arabic: arabic,dark: dark),
            ),
          );
        },
        onFieldSubmitted: (String input){function(input);},
      ),
    );
  }
}