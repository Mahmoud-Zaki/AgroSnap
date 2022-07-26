import 'package:agrosnap/Componants/CustomAppBarDlegate.dart';
import 'package:agrosnap/Provider/AdviceAndArticleNotifier.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleAndAdvice extends StatefulWidget{
  String title,img,id;
  bool dark,arabic,advice;
  ArticleAndAdvice({required this.id, required this.title,required this.advice,
    required this.img, required this.dark, required this.arabic});

  @override
  State<ArticleAndAdvice> createState() => _ArticleAndAdviceState();
}

class _ArticleAndAdviceState extends State<ArticleAndAdvice> {

  @override
  void initState() {
    Provider.of<AdviceAndArticleNotifier>(context,listen: false)
      .getAdviceOrArticleContent(arabic: widget.arabic, advice: widget.advice, id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: (widget.dark)?Constants.black:null,
        body: Directionality(
          textDirection: (widget.arabic)?TextDirection.rtl:TextDirection.ltr,
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: CustomAppBarDelegate(context:context,img: widget.img,title: widget.title)
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Constants.getScreenWidth(context)*0.016),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        General.sizeBoxVertical(Constants.getScreenHeight(context)*0.04),
                        General.buildTxt(txt: widget.title,color: (widget.dark)?Constants.darkLoop:Constants.primaryColor,fontSize: 30,noTranslate: true),
                        General.sizeBoxVertical(Constants.getScreenHeight(context)*0.04),
                        Consumer<AdviceAndArticleNotifier>(
                          builder: (context,content,child){
                            if(content.content=="")
                              return Padding(padding: EdgeInsets.only(
                                  top: Constants.getScreenHeight(context)*0.1,
                                  right: Constants.getScreenWidth(context)*0.2,
                                  left: Constants.getScreenWidth(context)*0.2
                                ),
                                child: Center(child: General.customLoading(color: (widget.dark)?Constants.darkLoop:Constants.primaryColor,isCircle: true)),
                              );
                            return General.buildTxt(txt: content.content,color: (widget.dark)?Constants.whiteTopGrading:Constants.black,noTranslate: true,fontSize: 24);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}