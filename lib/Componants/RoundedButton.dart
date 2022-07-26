import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget{
  Color color;
  String txt;
  bool isLoading,isEmptyColor,smallPV;
  Function function;
  double horizontalPadding;
  double? width;
  RoundedButton({
    required this.color, required this.txt,required this.horizontalPadding,this.width,
    required this.function, this.isLoading=false,this.isEmptyColor=false,this.smallPV=false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: (width!=null)?Constants.getScreenWidth(context)*width!:null,
        padding: EdgeInsets.symmetric(
          horizontal: Constants.getScreenWidth(context)*horizontalPadding,
          vertical: (smallPV)? Constants.getScreenHeight(context)*0.0046
              : Constants.getScreenHeight(context)*0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.0),
          color: (isEmptyColor)?Colors.transparent:color,
          border: (isEmptyColor)?Border.all(color: color,width: 2):null,
        ),
        child: Center(child:(isLoading) ? General.customLoading(color: (isEmptyColor)?color:Constants.white)
            : General.buildTxt(txt: txt, color: (isEmptyColor)?color:Constants.white,fontSize: 24))
      ),
      onTap: (){function();},
    );
  }
}