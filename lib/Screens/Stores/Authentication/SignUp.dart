import 'package:agrosnap/Animation/PagrRouteTransition.dart';
import 'package:agrosnap/Componants/CommonTopOfScreen.dart';
import 'package:agrosnap/Componants/CustomFormField.dart';
import 'package:agrosnap/Componants/RoundedButton.dart';
import 'package:agrosnap/Provider/AuthNotifier.dart';
import 'package:agrosnap/Screens/Stores/Authentication/Login.dart';
import 'package:agrosnap/Screens/Stores/StorePage/StorePage.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget{
  bool arabic,dark;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignUp({this.arabic = true,this.dark = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.secondaryColor,
        body: Directionality(
          textDirection: (arabic) ? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            children: [
              CommonTopOfScreen(img: "Assets/palm.png", height: Constants.getScreenHeight(context)*0.25),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    left: Constants.getScreenWidth(context)*0.05,
                    right: Constants.getScreenWidth(context)*0.05,
                    top: Constants.getScreenHeight(context)*0.02
                  ),
                  height: Constants.getScreenHeight(context)*0.75,
                  decoration: BoxDecoration(
                    color: (dark)?Constants.black:Constants.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          General.sizeBoxVertical(Constants.getScreenHeight(context)*0.005),
                          General.buildTxt(txt: "تسجيل جديد",isBold: true,fontSize: 36.0,
                              color: (dark)?Constants.secondaryColor:Constants.black),
                          General.sizeBoxVertical(Constants.getScreenHeight(context)*0.02),
                          General.buildTxt(txt: "البريد الإلكتروني",color: Constants.blueGray),
                          General.sizeBoxVertical(Constants.getScreenHeight(context)*0.006),
                          CustomFormField(email: true,dark: dark,function: (String input){
                            Provider.of<AuthNotifier>(context,listen: false).setEmail(input: input);
                          }),
                          General.sizeBoxVertical(Constants.getScreenHeight(context)*0.01),
                          General.buildTxt(txt: "كلمة المرور",color: Constants.blueGray),
                          General.sizeBoxVertical(Constants.getScreenHeight(context)*0.006),
                          CustomFormField(pass: true,dark: dark,function: (String input){
                            Provider.of<AuthNotifier>(context,listen: false).setPassword(input: input);
                          }),
                          General.sizeBoxVertical(Constants.getScreenHeight(context)*0.01),
                          General.buildTxt(txt: "اسم المتجر",color: Constants.blueGray),
                          General.sizeBoxVertical(Constants.getScreenHeight(context)*0.006),
                          CustomFormField(done: true,dark: dark,function: (String input){
                            Provider.of<AuthNotifier>(context,listen: false).setStoreName(input: input);
                          }),
                          General.sizeBoxVertical(Constants.getScreenHeight(context)*0.02),
                          Center(
                            child: Consumer<AuthNotifier>(
                              builder: (context,auth,child){
                                return RoundedButton(color: Constants.primaryColor, txt: "تسجيل",horizontalPadding: 0.1,
                                    isLoading: auth.loading,width: 0.4, function: () async{
                                      if(_formKey.currentState!.validate()){
                                        _formKey.currentState!.save();
                                        final response=await auth.register(arabic: arabic,dark: dark);
                                        if(response)
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => StorePage(arabic: arabic,isOwner: true,dark: dark,store: auth.store)
                                            ),
                                                (route) => false,
                                          );
                                      }
                                    }
                                );
                              },
                            )
                          ),
                          General.sizeBoxVertical(Constants.getScreenHeight(context)*0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              General.buildTxt(txt: "هل لديك حساب بالفعل؟",
                                  color: Constants.blueGray,fontSize: 18.0,isBold: false),
                              General.sizeBoxHorizontal(6.0),
                              InkWell(
                                child: General.buildTxt(txt: "تسجيل الدخول", color: Constants.primaryColor),
                                onTap: (){Navigator.push(context, SlideRoute(page: Login(arabic: arabic,dark:dark)));},
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}