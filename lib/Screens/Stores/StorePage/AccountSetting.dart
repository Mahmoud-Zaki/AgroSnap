import 'package:agrosnap/Componants/CustomTextField.dart';
import 'package:agrosnap/Provider/StorePageNotifier.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountSetting extends StatelessWidget{
  bool arabic,dark;
  String name,phone,facebookLink,anotherLink;

  AccountSetting({required this.arabic,required this.dark, required this.name,
    required this.phone,required this.anotherLink,required this.facebookLink});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: (dark)?Constants.black:null,
        body: Directionality(
          textDirection: (arabic) ? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(icon: Icon(Icons.close,color: (dark)?Constants.primaryColor:Constants.secondaryColor),
                    onPressed: (){
                      Navigator.of(context).pop();
                    }
                  ),
                  General.buildTxt(txt: "ضبط الحساب",fontSize: 30,color: (dark)?Constants.darkLoop:Constants.gray,pRight: 6,pLeft: 6,pTop: 20),
                  Expanded(child: SizedBox()),
                  IconButton(icon: Icon(Icons.done,color: (dark)?Constants.primaryColor:Constants.secondaryColor),
                    onPressed: () {
                      Provider.of<StorePageNotifier>(context,listen: false).editStore(dark: dark,arabic: arabic);
                      Navigator.of(context).pop();
                    }
                  )
                ],
              ),
              General.sizeBoxVertical(Constants.getScreenHeight(context)*0.02),
              CustomTextField(name: true,arabic: arabic,dark: dark,value:name),
              Padding(
                padding: (arabic)? EdgeInsets.only(right: Constants.getScreenWidth(context)*0.16,left: 10)
                    : EdgeInsets.only(left: Constants.getScreenWidth(context)*0.16,right: 10),
                child: Divider(thickness: 1.5,color: (dark)?Constants.primaryColor:null),
              ),
              General.sizeBoxVertical(Constants.getScreenHeight(context)*0.016),
              CustomTextField(phone: true,arabic: arabic,dark: dark,value:phone),
              Padding(
                padding: (arabic)? EdgeInsets.only(right: Constants.getScreenWidth(context)*0.16,left: 10)
                    : EdgeInsets.only(left: Constants.getScreenWidth(context)*0.16,right: 10),
                child: Divider(thickness: 1.5,color: (dark)?Constants.primaryColor:null),
              ),
              General.sizeBoxVertical(Constants.getScreenHeight(context)*0.016),
              CustomTextField(faceLink: true,arabic: arabic,dark: dark,value:facebookLink),
              Padding(
                padding: (arabic)? EdgeInsets.only(right: Constants.getScreenWidth(context)*0.16,left: 10)
                    : EdgeInsets.only(left: Constants.getScreenWidth(context)*0.16,right: 10),
                child: Divider(thickness: 1.5,color: (dark)?Constants.primaryColor:null),
              ),
              General.sizeBoxVertical(Constants.getScreenHeight(context)*0.016),
              CustomTextField(anotherLink: true,arabic: arabic,dark:dark,value:anotherLink),
              Padding(
                padding: (arabic)? EdgeInsets.only(right: Constants.getScreenWidth(context)*0.16,left: 10)
                    : EdgeInsets.only(left: Constants.getScreenWidth(context)*0.16,right: 10),
                child: Divider(thickness: 1.5,color: (dark)?Constants.primaryColor:null),
              ),
            ],
          ),
        ),
      )
    );
  }
}