import 'package:agrosnap/Provider/AdviceAndArticleNotifier.dart';
import 'package:agrosnap/Screens/Articles&Advices/Articles&Advices.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticlesList extends StatelessWidget{
  bool dark,arabic;
  ArticlesList({required this.dark,required this.arabic});
  @override
  Widget build(BuildContext context) {
    double width=Constants.getScreenWidth(context);
    return SizedBox(
      height: Constants.getScreenHeight(context)*0.26,
      child: Consumer<AdviceAndArticleNotifier>(
        builder: (context,article,child){
          if(article.articles.length==0)
            return Center(child: General.customLoading(color: (dark)?Constants.darkLoop:Constants.primaryColor,isCircle: true));
          return ListView.builder(
              padding: EdgeInsets.only(right: width*0.03),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: article.articles.length,
              itemBuilder: (BuildContext context,int index){
                return InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16,right: 6,top: 4,bottom: 10),
                    width: width*0.38,
                    decoration: BoxDecoration(
                      color: (dark)?Constants.darkBlueLight:Constants.white,
                      borderRadius: BorderRadius.circular(30.0),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(article.articles[index].img),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Constants.blueGray.withOpacity(0.5),
                          blurRadius: 4,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        height: Constants.getScreenHeight(context)*0.1,
                        width: width*0.38,
                        decoration: BoxDecoration(
                          color: Constants.black.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30)
                          ),
                        ),
                        child: Center(child: General.buildTxt(txt: article.articles[index].title,color: Constants.white,noTranslate: true)),
                      ),
                    ),
                  ),
                  onTap: (){
                    article.emptyContent();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleAndAdvice(
                      id: article.articles[index].id, title: article.articles[index].title,
                      img: article.articles[index].img,dark: dark,arabic: arabic,advice: false)));
                  },
                );
              }
          );
        },
      )
    );
  }
}