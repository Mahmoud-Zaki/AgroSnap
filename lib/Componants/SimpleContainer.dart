import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';

class SimpleContainer extends StatelessWidget{
  String txt;
  SimpleContainer({required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.getScreenWidth(context)*0.26,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60.0),
        color: Constants.primaryColor,
      ),
      child: Center(
        child: General.buildTxt(
            txt: txt,isBold: false,color: Constants.white
        ),
      )
    );
  }
}