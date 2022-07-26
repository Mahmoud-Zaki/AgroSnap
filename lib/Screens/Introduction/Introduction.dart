import 'package:agrosnap/Componants/SimpleContainer.dart';
import 'package:agrosnap/Provider/SettingNotifier.dart';
import 'package:agrosnap/Screens/Home/Home.dart';
import 'package:agrosnap/Screens/Stores/Authentication/SignUp.dart';
import 'package:agrosnap/Services/SharedPreference.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class Introduction extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: Constants.getScreenHeight(context)*0.02,
                horizontal: Constants.getScreenWidth(context)*0.06
              ),
              child: InkWell(
                child: General.buildTxt(
                  txt: "تخطي",color: Constants.primaryColor,
                  isBold: false),
                  onTap: (){
                    SharedPreferenceHandler.setSawIntro();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Selector<SettingNotifier,bool>(
                            selector: (context,language)=>language.getArLanguage,
                            builder: (context,arabic,child){
                              Provider.of<SettingNotifier>(context,listen: false).getData();
                              return Directionality(
                                  textDirection: (arabic) ? TextDirection.rtl : TextDirection.ltr,
                                  child: Selector<SettingNotifier,bool>(
                                      selector: (context,setting)=>setting.dark,
                                      builder: (context,dark,child) => Home(dark: dark)
                                  )
                              );
                            },
                          )
                      ),
                          (route) => false,
                    );
                  },
              ),
            ),
            Expanded(
              child: IntroductionScreen(
                pages: [
                  PageViewModel(
                    image: Image.asset("Assets/intro1.png"),
                    titleWidget: General.buildTxt(
                      txt: "التعرف على النبات",fontSize: 26,),
                    bodyWidget: General.buildTxt(
                      txt: "يمكنك معرفة كل ما تحتاجة عن النبات من معلومات من خلال صورته\nوأيضا معرفة إذا كان النبات مريض أم لا؟ وطريقة علاجه",
                      isBold: false,color: Constants.blueGray
                    ),
                  ),
                  PageViewModel(
                    image: Image.asset("Assets/intro2.png"),
                    titleWidget: General.buildTxt(
                        txt: "رعاية النبات",fontSize: 26,),
                    bodyWidget: General.buildTxt(
                        txt: "يمكنك معرفة كل طرق العناية ورعاية النبات من الأمراض",
                        isBold: false,color: Constants.blueGray
                    ),
                  ),
                  PageViewModel(
                    image: Image.asset("Assets/intro3.png"),
                    titleWidget: General.buildTxt(
                        txt: "شراء النبات",fontSize: 26,),
                    bodyWidget: General.buildTxt(
                        txt: "اقتراح اقرب المتاجر التي تبيع النبات الذي تبحث عنه",
                        isBold: false,color: Constants.blueGray
                    ),
                  ),
                  PageViewModel(
                    image: Image.asset("Assets/intro4.png"),
                    titleWidget: General.buildTxt(
                        txt: "المتاجر",fontSize: 26,),
                    bodyWidget: General.buildTxt(
                        txt: "يمكنك إنشاء حساب كمتجر للنباتات وعرض منتجاتلك ليتوصل إليك المستخدمين سريعا",
                        isBold: false,color: Constants.blueGray
                    ),
                  ),
                ],
                done: SimpleContainer(txt: "ابدأ"),
                next: SimpleContainer(txt: "التالي"),
                onDone: (){
                  SharedPreferenceHandler.setSawIntro();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Selector<SettingNotifier,bool>(
                        selector: (context,language)=>language.getArLanguage,
                        builder: (context,arabic,child){
                          Provider.of<SettingNotifier>(context,listen: false).getData();
                          return Directionality(
                              textDirection: (arabic) ? TextDirection.rtl : TextDirection.ltr,
                              child: Selector<SettingNotifier,bool>(
                                  selector: (context,setting)=>setting.dark,
                                  builder: (context,dark,child) => Home(dark: dark)
                              )
                          );
                        },
                      )
                    ),
                        (route) => false,
                  );
                },
                dotsContainerDecorator: BoxDecoration(
                ),
                dotsDecorator: DotsDecorator(
                  size: const Size.square(16.0),
                  activeSize: const Size(24.0, 12.0),
                  activeColor: Constants.primaryColor,
                  color: Constants.blueLight,
                  spacing: const EdgeInsets.symmetric(horizontal: 4.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}