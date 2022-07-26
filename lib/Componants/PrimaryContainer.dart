import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PrimaryContainer extends StatelessWidget{
  String title, img;
  Color titleColor;
  bool recommended,dark,home;
  Function? function;
  PrimaryContainer({required this.title,required this.img,this.function,
    required this.titleColor,this.recommended=false,this.dark=false,this.home=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: (recommended)?null:Constants.getScreenWidth(context)*0.46,
        margin: (recommended)? EdgeInsets.only(top: 4,bottom: 10,
            right: Constants.getScreenWidth(context)*0.05,left: Constants.getScreenWidth(context)*0.05)
            : const EdgeInsets.only(left: 16,right: 10,top: 4,bottom: 10),
        padding: (recommended)?const EdgeInsets.only(bottom: 10):null,
        decoration: BoxDecoration(
          color: (dark)?Constants.darkBlueLight:Constants.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Constants.blueGray.withOpacity(0.5),
              blurRadius: 4,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: (home)?Constants.getScreenHeight(context)*0.2:Constants.getScreenHeight(context)*0.16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(child: Center(child: General.buildTxt(txt: title,color: titleColor,noTranslate: true))),
          ],
        ),
      ),
      onTap: (){function!();},
    );
  }
}