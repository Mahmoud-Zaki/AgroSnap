import 'dart:ui';
import 'package:agrosnap/Provider/NavigationNotifier.dart';
import 'package:agrosnap/Provider/SearchNotifier.dart';
import 'package:agrosnap/Provider/SettingNotifier.dart';
import 'package:agrosnap/Screens/Garden/MyGarden.dart';
import 'package:agrosnap/Screens/Home/HomeBody.dart';
import 'package:agrosnap/Screens/Plant/loading.dart';
import 'package:agrosnap/Screens/Setting/Setting.dart';
import 'package:agrosnap/Screens/Stores/ShowStores/Stores.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  bool dark;
  Home({required this.dark});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool entryOpened = false;
  OverlayEntry? entry;

  @override
  void initState() {
    super.initState();
    entry = OverlayEntry(
      builder: (context) {
        var navigationNotify = Provider.of<NavigationNotifier>(context,listen: false);
        bool arabic = Provider.of<SettingNotifier>(context,listen: false).getArLanguage;
        bool dark = Provider.of<SettingNotifier>(context,listen: false).dark;
        var img = Provider.of<SearchNotifier>(context,listen: false);
        return Container(
          height: Constants.getScreenHeight(context),
          width: Constants.getScreenWidth(context),
          color: Constants.black.withOpacity(0.6),
          padding: EdgeInsets.only(
            bottom: Constants.getScreenHeight(context)*0.044
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  General.buildBottomModelSheet(context: context, isEdit: false, arabic: arabic,dark: widget.dark,
                      uploadImage: true,function1: () {img.getImgFromPhone(isCamera: true,type: 'f',arabic: arabic,dark: dark);navigationNotify.setPageIndex(value: 4);},
                      function2: () {img.getImgFromPhone(isCamera: false,type: 'f',arabic: arabic,dark: dark);navigationNotify.setPageIndex(value: 4);});
                  entry!.remove();
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (!widget.dark)?Constants.white:null,
                      shape: BoxShape.circle,
                      gradient: (!widget.dark)?null:LinearGradient(
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                          colors: [
                            Constants.darkLoop,
                            Constants.darkLoopGrading
                          ]
                      ),
                    ),
                    child: Image.asset("Assets/fruits.png",color: (widget.dark)?Constants.whiteTopGrading:Constants.secondaryColor,width: 30,height: 30,)
                ),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(0),
                  elevation: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      General.buildBottomModelSheet(context: context, isEdit: false, arabic: arabic,dark: widget.dark,
                          uploadImage: true,function1: () {img.getImgFromPhone(isCamera: true,type: 'd',arabic: arabic,dark: dark);navigationNotify.setPageIndex(value: 5);},
                          function2: () {img.getImgFromPhone(isCamera: false,type: 'd',arabic: arabic,dark: dark);navigationNotify.setPageIndex(value: 5);});
                      entry!.remove();
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (!widget.dark)?Constants.white:null,
                          shape: BoxShape.circle,
                          gradient: (!widget.dark)?null:LinearGradient(
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight,
                              colors: [
                                Constants.darkLoop,
                                Constants.darkLoopGrading
                              ]
                          ),
                        ),
                        child: Image.asset("Assets/withered.png",color: (widget.dark)?Constants.whiteTopGrading:Constants.secondaryColor,width: 30,height: 30,)
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(0),
                      elevation: 20,
                    ),
                  ),
                  General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.16),
                  ElevatedButton(
                    onPressed: () {
                      General.buildBottomModelSheet(context: context, isEdit: false, arabic: arabic,dark: widget.dark,
                          uploadImage: true,function1: () {img.getImgFromPhone(isCamera: true,type: 'h',arabic: arabic,dark: dark);navigationNotify.setPageIndex(value: 6);},
                          function2: () {img.getImgFromPhone(isCamera: false,type: 'h',arabic: arabic,dark: dark);navigationNotify.setPageIndex(value: 6);});
                      entry!.remove();
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (!widget.dark)?Constants.white:null,
                          shape: BoxShape.circle,
                          gradient: (!widget.dark)?null:LinearGradient(
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight,
                              colors: [
                                Constants.darkLoop,
                                Constants.darkLoopGrading
                              ]
                          ),
                        ),
                        child: Image.asset("Assets/plant.png",color: (widget.dark)?Constants.whiteTopGrading:Constants.secondaryColor,width: 30,height: 30,)
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(0),
                      elevation: 20,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  entry!.remove();
                  navigationNotify.setBlur();
                },
                child: General.sizeBoxHorizontal(0.0),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10),
                  primary: Colors.transparent,
                  elevation: 20,
                ),
              ),
            ],
          )
        );
      },
    );
  }

  @override
  void dispose() {
    entry!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var navigationNotify = Provider.of<NavigationNotifier>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: (widget.dark)?Constants.black:Constants.white,
        body: Consumer<NavigationNotifier>(
          builder: (context,setting,child){
            switch(setting.index){
              case 0:
                return SafeArea(child: ImageFiltered(
                      imageFilter: (setting.blur)?ImageFilter.blur(sigmaX: 3, sigmaY: 3):ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                      child: HomeBody()
                  ),
                );
              case 1:
                return ImageFiltered(
                    imageFilter: (setting.blur)?ImageFilter.blur(sigmaX: 3, sigmaY: 3):ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: MyGarden()
                );
              case 2:
                return ImageFiltered(
                    imageFilter: (setting.blur)?ImageFilter.blur(sigmaX: 3, sigmaY: 3):ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: ShowStores()
                );
              case 3:
                return ImageFiltered(
                    imageFilter: (setting.blur)?ImageFilter.blur(sigmaX: 3, sigmaY: 3):ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Setting()
                );
            }
            return ImageFiltered(
                imageFilter: (setting.blur)?ImageFilter.blur(sigmaX: 3, sigmaY: 3):ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Loading()
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: InkWell(
          child: Container(
            height: 70.0,
            width: 70.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
                  (widget.dark)?Constants.darkLoop:Constants.primaryColor,
                  (widget.dark)?Constants.darkLoopGrading:Constants.primaryColorGrading
                ]
              ),
              boxShadow: [
                BoxShadow(
                  color: Constants.blueGray.withOpacity(0.5),
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Selector<NavigationNotifier,bool>(
              selector: (context,blury)=>blury.getBlur,
              builder: (context,blur,child){
                return Icon((blur)?Icons.close:Icons.camera_alt,size: 38,color: Constants.white);
              },
            ),
          ),
          onTap: () async{
            Overlay.of(context)!.insert(entry!);
            navigationNotify.setBlur();
          },
        ),
        bottomNavigationBar: SizedBox(
          height: Constants.getScreenHeight(context)*0.08,
          child: BottomAppBar(
            color: (widget.dark)?Constants.darkBlueLight:null,
            shape: CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Selector<NavigationNotifier,int>(
              selector: (context,navigate)=>navigate.getIndex,
              builder: (context,index,child){
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.home_rounded,size: 36,color: (index==0)?(widget.dark)?Constants.darkLoop:
                      Constants.primaryColor:(widget.dark)?Constants.darkGrayLight:Constants.grayLight),
                      onPressed: () {navigationNotify.setPageIndex(value: 0);},
                    ),
                    IconButton(
                      icon: Image.asset("Assets/plantCare.png",height: 26,width: 30,color: (index==1)?(widget.dark)?Constants.darkLoop:
                      Constants.primaryColor:(widget.dark)?Constants.darkGrayLight:Constants.grayLight),
                      onPressed: () {navigationNotify.setPageIndex(value: 1);},
                    ),
                    General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.01),
                    General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.01),
                    IconButton(
                      icon: Icon(Icons.storefront_rounded,size: 34,color: (index==2)?(widget.dark)?Constants.darkLoop:
                      Constants.primaryColor:(widget.dark)?Constants.darkGrayLight:Constants.grayLight),
                      onPressed: () {navigationNotify.setPageIndex(value: 2);},
                    ),
                    IconButton(
                      icon: Icon(Icons.settings,size: 36,color: (index==3)?(widget.dark)?Constants.darkLoop:
                      Constants.primaryColor:(widget.dark)?Constants.darkGrayLight:Constants.grayLight),
                      onPressed: () {navigationNotify.setPageIndex(value: 3);},
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}