import 'dart:convert';
import 'dart:io';
import 'package:agrosnap/Componants/CustomFormField.dart';
import 'package:agrosnap/Componants/RoundedButton.dart';
import 'package:agrosnap/Models/Product.dart';
import 'package:agrosnap/Provider/RemindersNotififier.dart';
import 'package:agrosnap/Provider/SettingNotifier.dart';
import 'package:agrosnap/Provider/StorePageNotifier.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class General {
  static sizeBoxHorizontal(space) {
    return SizedBox(
      width: space,
    );
  }

  static sizeBoxVertical(space) {
    return SizedBox(
      height: space,
    );
  }

  static buildTxt({required String txt, double pLeft=0, double pTop=0,
    Color color = Constants.black, double pRight=0, double pBottom=0,
    double fontSize = 20.0, bool isBold = true,bool noTranslate=false}) {
    return Consumer<SettingNotifier>(
        builder: (context,setting,child) {
          return Padding(
            padding: EdgeInsets.only(left: pLeft,bottom: pBottom,right: pRight,top: pTop),
            child: Text((setting.getArLanguage||noTranslate)?txt:Constants.translate[txt].toString(),
              style: TextStyle(
                  color: color,
                  fontFamily: "Montserrat",
                  fontSize: (setting.largeFontSize)?fontSize:fontSize-5,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            ),
          );
        }
    );
  }

  static customLoading({required Color color, bool isCircle = false,bool doubleBounce = false}) {
    return Center(
      child: (isCircle) ? SpinKitCircle(color: color, size: 64.0) : (doubleBounce) ?
        SpinKitDoubleBounce(color: color, size: 100) :
        SpinKitThreeBounce(color: color, size: 30.0),
    );
  }

  static buildDialog({required context,required String title,required Widget content,
    String? actionText,Function? function,required bool dark}) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => Theme(
        data: (dark)?ThemeData.dark():ThemeData.light(),
        child: CupertinoAlertDialog(
          title: buildTxt(txt: title,color: (dark)?Constants.darkLoop:Constants.gray,fontSize: 26.0),
          content: content,
          actions: (actionText==null)?<Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: buildTxt(txt: 'إلغاء',fontSize: 24.0,color: (dark)?Constants.darkOrange:Constants.orange),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ]:<Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: buildTxt(txt: 'إلغاء',fontSize: 24.0,color: (dark)?Constants.darkOrange:Constants.orange),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: buildTxt(txt: actionText,fontSize: 24.0,color: Constants.darkPhoneColor),
              onPressed: (){
                if(actionText=="تسجيل الخروج"){
                  Navigator.of(context).pop();
                  function!();
                } else{
                  function!();
                  Navigator.of(context).pop();
                }
              }
            ),
          ]
        ),
      )
    );
  }

  static void buildToast({required String msg,required bool dark}){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: (dark)?Constants.darkBlueLight.withOpacity(0.5):Constants.grayLight.withOpacity(0.4)
    );
  }

  static void buildBottomModelSheet({required context,Function? function1,required bool dark,String price="",
    required bool isEdit,required bool arabic,bool uploadImage=false,Function? function2,String name=""}){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: (dark)?Constants.darkBlueLight:null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: Constants.getScreenWidth(context)*0.05,right: Constants.getScreenWidth(context)*0.05,
            bottom: MediaQuery.of(context).viewInsets.bottom,top: Constants.getScreenHeight(context)*0.01
          ),
          child: Directionality(
            textDirection: (arabic)?TextDirection.rtl:TextDirection.ltr,
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: (uploadImage)?CrossAxisAlignment.start:CrossAxisAlignment.center,
                children: (uploadImage)?<Widget>[
                  buildTxt(txt: "اختر",color: Constants.halfGray,fontSize: 26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          child: Icon(Icons.camera_alt_rounded,size: 30,color: Constants.white),
                          backgroundColor: Constants.loopColor, radius: 26
                        ),
                        onTap: (){
                          function1!();
                          Navigator.pop(context);
                        },
                      ),
                      sizeBoxHorizontal(Constants.getScreenWidth(context)*0.05),
                      InkWell(
                        child: CircleAvatar(
                          child: Icon(CupertinoIcons.photo,size: 30,color: Constants.white),
                          backgroundColor: Constants.loopColor, radius: 26
                        ),
                        onTap: (){
                          function2!();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ]:<Widget>[
                  Selector<StorePageNotifier,File?>(
                    selector: (context,product)=>product.getProductImg,
                    builder: (context,img,child){
                      return InkWell(
                        child: CircleAvatar(
                            child: (img==null)?Icon(Icons.add_a_photo_rounded,size: 60,color: Constants.white):null,
                            backgroundImage: (img==null)?null:FileImage(img),
                            backgroundColor: Constants.primaryColor, radius: 40
                        ),
                        onTap: (){
                          buildBottomModelSheet(context: context, isEdit: false, arabic: arabic,dark: dark,
                            uploadImage: true,function1: (){Provider.of<StorePageNotifier>(context,listen: false)
                                  .getImgFromPhone(isCamera: true, pProduct: true,dark: dark,context: context,arabic: arabic);},function2: (){
                            Provider.of<StorePageNotifier>(context,listen: false)
                                .getImgFromPhone(isCamera: false, pProduct: true,dark: dark,context: context,arabic: arabic);});
                        },
                      );
                    },
                  ),
                  CustomFormField(function: (input){
                    Provider.of<StorePageNotifier>(context,listen: false).setData(input: input, type: "productName");
                  },isEditPlant: true,value:name),
                  Align(
                    alignment: (arabic)?Alignment.topRight:Alignment.topLeft,
                    child: CustomFormField(isEditPlant: true,cost: true,done: true,value:price,
                      function: (input){
                        Provider.of<StorePageNotifier>(context,listen: false).setData(input: input, type: "productPrice");
                      }
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RoundedButton(color: Constants.primaryColor, txt: (isEdit)?"تعديل":"إضافة",
                        horizontalPadding: 0.086,smallPV: true,
                        function: (){
                          (isEdit)?Provider.of<StorePageNotifier>(context,listen: false).editProduct(arabic: arabic, dark: dark)
                              : Provider.of<StorePageNotifier>(context,listen: false).addProduct(arabic: arabic, dark: dark);
                          Navigator.pop(context);
                        }
                      ),
                      RoundedButton(color: Constants.primaryColor, txt: (isEdit)?"حذف":"إلغاء",
                        horizontalPadding: 0.086,isEmptyColor: true,smallPV: true,
                        function: (){
                          if(isEdit)
                            Provider.of<StorePageNotifier>(context,listen: false).deleteProduct(arabic: arabic, dark: dark);
                          Navigator.pop(context);
                        }
                      ),
                    ],
                  )
                ],
              )
            ),
          )
        );
      },
    );
  }
}