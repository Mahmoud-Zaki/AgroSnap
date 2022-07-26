import 'package:agrosnap/Provider/SettingNotifier.dart';
import 'package:agrosnap/Provider/StorePageNotifier.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget{
  bool name,phone,faceLink,anotherLink,arabic,dark;
  String value;
  CustomTextField({required this.arabic, this.anotherLink = false,required this.dark,
    this.faceLink = false, this.name = false, this.phone = false,this.value = ""});

  Icon _getPrefixIcon(){
    if(phone)
      return Icon(Icons.phone,color: (dark)?Constants.primaryColor:Constants.blueGray,size: 30);
    else if(faceLink)
      return Icon(Icons.facebook_rounded,color: (dark)?Constants.primaryColor:Constants.blueGray,size: 30);
    else if(anotherLink)
      return Icon(Icons.link,color: (dark)?Constants.primaryColor:Constants.blueGray,size: 30);
    else
      return Icon(Icons.storefront_rounded,color: (dark)?Constants.primaryColor:Constants.blueGray,size: 30);
  }

  String _getHintText(){
    if(phone)
      return (value!="")?value:(arabic)?"رقم الهاتف":"Phone Number";
    else if(faceLink)
      return (value!="")?value:(arabic)?"رابط Facebook":"Facebook URL";
    else if(anotherLink)
      return (value!="")?value:(arabic)?"رابط اخر":"Another URL";
    else
      return (value!="")?value:(arabic)?"اسم المتجر":"Store Name";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.03),
        _getPrefixIcon(),
        General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.09),
        Expanded(
          child: TextField(
            textAlign: TextAlign.start,
            keyboardType: (phone)?TextInputType.phone:TextInputType.text,
            autofocus: false,
            decoration: InputDecoration(
              hintText: _getHintText(),
              hintStyle: TextStyle(
                fontSize: 20.0,
                color: Constants.blueGray,
              ),
              border: InputBorder.none
            ),
            style: TextStyle(
             fontSize: 20.0, color: Constants.blueGray),
            cursorColor: Constants.secondaryColor,
            onChanged: (input){
              String type = "";
              if(faceLink)
                type = "facebook";
              else if(name)
                type = "name";
              else if (phone)
                type = "phone";
              else if(anotherLink)
                type="another";
              Provider.of<StorePageNotifier>(context,listen: false).setData(input: input, type: type);
            },
          ),
        ),
      ],
    );
  }
}