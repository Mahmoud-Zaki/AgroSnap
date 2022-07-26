import 'package:agrosnap/Componants/ArticlesList.dart';
import 'package:agrosnap/Componants/PrimaryContainer.dart';
import 'package:agrosnap/Componants/ReminderContainer.dart';
import 'package:agrosnap/Componants/SearchBar.dart';
import 'package:agrosnap/Provider/AdviceAndArticleNotifier.dart';
import 'package:agrosnap/Provider/AuthNotifier.dart';
import 'package:agrosnap/Provider/RemindersNotififier.dart';
import 'package:agrosnap/Provider/SettingNotifier.dart';
import 'package:agrosnap/Screens/Articles&Advices/Articles&Advices.dart';
import 'package:agrosnap/Screens/Stores/Authentication/SignUp.dart';
import 'package:agrosnap/Screens/Stores/StorePage/StorePage.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget{
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  @override
  void initState() {
    super.initState();
    bool arabic = Provider.of<SettingNotifier>(context,listen: false).getArLanguage;
    Provider.of<RemindersNotifier>(context,listen: false).getTodayPlants(arabic: arabic);
  }

  @override
  Widget build(BuildContext context) {
    var notify= Provider.of<SettingNotifier>(context,listen: false);
    Provider.of<AdviceAndArticleNotifier>(context,listen: false).getAllArticles(arabic: notify.getArLanguage);
    Provider.of<AdviceAndArticleNotifier>(context,listen: false).getAllAdvice(arabic: notify.getArLanguage);
    return Container(
      color: (notify.dark)?Constants.black:Constants.white,
      child: ListView(
        padding: EdgeInsets.only(top: Constants.getScreenHeight(context)*0.02),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Constants.getScreenWidth(context)*0.03),
            child: SizedBox(
              height: Constants.getScreenHeight(context)*0.08,
              child: Row(
                children: [
                  InkWell(
                    child: CircleAvatar(
                      child: Icon(Icons.person_rounded,color: (notify.dark)?Constants.darkBlueLight:Constants.white,size: 30),
                      backgroundColor: (notify.dark)?Constants.darkLoop:Constants.primaryColor,
                    ),
                    onTap: ()async{
                      final auth = Provider.of<AuthNotifier>(context,listen: false);
                      bool found = await auth.getMyStore();
                      if(found)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StorePage(arabic: notify.getArLanguage, isOwner: true, dark: notify.dark, store: auth.store),
                          ),
                        );
                      else
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(arabic: notify.getArLanguage,dark: notify.dark),
                          ),
                        );
                    },
                  ),
                  General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.03),
                  Expanded(child: SearchBar(readOnly: true, txt: "بحث عن النباتات",dark: notify.dark,function: (){})
                  ),
                ],
              ),
            ),
          ),
          General.buildTxt(txt: "تذكير",color: (notify.dark)?Constants.blueLight:Constants.primaryColor,fontSize: 30,
              pLeft: Constants.getScreenWidth(context)*0.03,pRight: Constants.getScreenWidth(context)*0.05),
          General.buildTxt(txt: "اليوم",color: (notify.dark)?Constants.blueLight:Constants.primaryColor,isBold: false,
              pLeft: Constants.getScreenWidth(context)*0.03,pRight: Constants.getScreenWidth(context)*0.05),
          Consumer<RemindersNotifier>(
            builder: (context,remind,child){
              return Container(
                height: (remind.plantsCare.isEmpty)?Constants.getScreenHeight(context)*0.12
                    : Constants.getScreenHeight(context)*0.26,
                margin: EdgeInsets.symmetric(
                    horizontal: Constants.getScreenWidth(context)*0.05,
                    vertical: Constants.getScreenHeight(context)*0.01
                ),
                padding: (remind.plantsCare.isEmpty)?EdgeInsets.only(
                    left: Constants.getScreenWidth(context)*0.02,
                    right: Constants.getScreenWidth(context)*0.02,
                    top: Constants.getScreenHeight(context)*0.01
                ):EdgeInsets.symmetric(horizontal: Constants.getScreenWidth(context)*0.02,
                    vertical: Constants.getScreenHeight(context)*0.01),
                decoration: BoxDecoration(
                  color: (notify.dark)?Color(0xff252525):Constants.white,
                  borderRadius: BorderRadius.circular(36.0),
                  boxShadow: [
                    BoxShadow(
                      color: Constants.blueGray.withOpacity(0.5),
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: (remind.plantsCare.isEmpty) ?
                Center(child: General.buildTxt(txt: "لا يوجد تذكير",color: (notify.dark)?Constants.whiteTopGrading:Constants.blueGray),) :
                ListView.builder(
                  itemCount: remind.plantsCare.length,padding: EdgeInsets.only(top: Constants.getScreenHeight(context)*0.02),
                  itemBuilder: (BuildContext context, int index){
                    return ReminderContainer(plantCare: remind.plantsCare[index],
                        arabic: notify.getArLanguage,dark: notify.dark,listIndex: index,home: true);
                  },
                ),
              );
            }
          ),
          General.buildTxt(txt: "مقالات",color: (notify.dark)?Constants.blueLight:Constants.primaryColor,fontSize: 30,
              pLeft: Constants.getScreenWidth(context)*0.03,pRight: Constants.getScreenWidth(context)*0.05),
          ArticlesList(dark: notify.dark,arabic: notify.getArLanguage),
          General.buildTxt(txt: "نصائح",color: (notify.dark)?Constants.blueLight:Constants.primaryColor,fontSize: 30,
              pLeft: Constants.getScreenWidth(context)*0.03,pRight: Constants.getScreenWidth(context)*0.05),
          SizedBox(
            height: Constants.getScreenHeight(context)*0.3,
            child: Consumer<AdviceAndArticleNotifier>(
              builder: (context,advice,child){
                if(advice.advices.length==0)
                  return Center(child: General.customLoading(color: (notify.dark)?Constants.darkLoop:Constants.primaryColor,isCircle: true));
                return ListView.builder(
                  padding: EdgeInsets.only(right: Constants.getScreenWidth(context)*0.03),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: advice.advices.length,
                  itemBuilder: (BuildContext context,int index){
                    return PrimaryContainer(title: advice.advices[index].title,img: advice.advices[index].img,
                      titleColor: (notify.dark)?Constants.white:Constants.black,dark: notify.dark,home:true,
                        function: () {
                          advice.emptyContent();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleAndAdvice(
                            id: advice.advices[index].id, title: advice.advices[index].title,advice: true,
                            img: advice.advices[index].img,dark: notify.dark,arabic: notify.getArLanguage)));
                        }
                    );
                  }
                );
              },
            )
          ),
        ],
      ),
    );
  }
}