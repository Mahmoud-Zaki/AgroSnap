import 'package:agrosnap/Models/StoreOwner.dart';
import 'package:agrosnap/Provider/AuthNotifier.dart';
import 'package:agrosnap/Provider/StorePageNotifier.dart';
import 'package:agrosnap/Screens/Home/Home.dart';
import 'package:agrosnap/Screens/Stores/Authentication/SignUp.dart';
import 'package:agrosnap/Screens/Stores/StorePage/AccountSetting.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomStoreHeaderDelegate extends SliverPersistentHeaderDelegate{
  final context;
  Color color;
  StoreOwner storeOwner;
  bool isOwner,arabic,dark;
  late List<Widget> options = [
    ListTile(leading: Icon(Icons.settings,color: (dark)?Constants.grayLight:null),title: General.buildTxt(txt: "ضبط الحساب",color: (dark)?Constants.grayLight:Constants.gray)),
    ListTile(leading: Icon(Icons.logout,color: (dark)?Constants.grayLight:null),title: General.buildTxt(txt: "تسجيل الخروج",color: (dark)?Constants.grayLight:Constants.gray)),
    ListTile(leading: Icon(Icons.person_remove,color: (dark)?Constants.grayLight:null),title: General.buildTxt(txt: "حذف الحساب",color: (dark)?Constants.grayLight:Constants.gray))
  ];

  CustomStoreHeaderDelegate({required this.context,required this.color,
    required this.storeOwner,required this.isOwner,required this.arabic,required this.dark});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double percent = shrinkOffset / maxExtent;
    return Container(
      decoration: BoxDecoration(
        color: color,
        image: DecorationImage(
          image: AssetImage("Assets/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,right: (arabic)?0:null,left: (arabic)?null:0,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Directionality(textDirection: (arabic)?TextDirection.rtl:TextDirection.ltr, child: Home(dark: dark)),
                  ),
                      (route) => false,
                );
              },
              color: Constants.grayLight,
            )
          ),
          (isOwner)?Positioned(
            top: 0,right: (arabic)?null:0,left: (arabic)?0:null,
            child: PopupMenuButton<Widget>(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
              elevation: 10.0,color: (dark)?Constants.darkBlueLight:null,
              icon: Icon(Icons.more_vert,color: Constants.grayLight),
              onSelected: (Widget choice){
                if(choice==options[0])
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSetting(arabic: arabic,dark: dark,
                    name: storeOwner.name??"",phone: storeOwner.phoneNumber??"",anotherLink: storeOwner.anotherLink??"",facebookLink: storeOwner.faceLink??"")));
                else if(choice==options[1]){
                  General.buildDialog(context: context, title: "تسجيل الخروج", content: SizedBox(),
                    dark: dark,actionText: "تسجيل الخروج",function: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Directionality(
                        textDirection: (arabic)?TextDirection.rtl:TextDirection.ltr,child: Home(dark: dark))),
                            (route) => false);
                    Provider.of<AuthNotifier>(context,listen: false).logOut();
                  });
                }
                else {
                  General.buildDialog(context: context, title: "حذف الحساب", content: SizedBox(),
                    dark: dark,actionText: "حذف الحساب",function: ()async{
                      await Provider.of<AuthNotifier>(context,listen: false).deleteAccount(id: storeOwner.id??"",dark: dark,arabic: arabic,context: context);
                    });
                  }
               },
              itemBuilder: (BuildContext context){
                return options.map((Widget choice){
                  return PopupMenuItem<Widget>(
                      value: choice,
                      child: Directionality(textDirection: (arabic)?TextDirection.rtl:TextDirection.ltr,child: choice)
                  );
                }).toList();
              },
            )
          ):Positioned(left: 0,child: General.sizeBoxVertical(0.0)),
          Positioned(
            bottom: 4,
            right: (arabic)?(Constants.getScreenWidth(context)*0.34*(1-percent)).clamp(
                Constants.getScreenWidth(context)*0.1, Constants.getScreenWidth(context)*0.34):null,
            left: (arabic)?null:(Constants.getScreenWidth(context)*0.34*(1-percent)).clamp(
                Constants.getScreenWidth(context)*0.1, Constants.getScreenWidth(context)*0.34),
            child: CircleAvatar(
              backgroundColor: color,
              radius: (60*(1-percent)).clamp(22, 60),
              child: Selector<StorePageNotifier,String>(
                selector: (context,profile)=>profile.getProfileImg,
                builder: (context,img,child){
                  return CircleAvatar(
                      child: (img=="")?Icon(Icons.person_rounded,size: (100*(1-percent)).clamp(26, 100), color: (dark)?Constants.darkBlueLight:Constants.white):null,
                      backgroundImage: (img=="")?null:CachedNetworkImageProvider(img),
                      backgroundColor: (dark)?Constants.darkLoop:Constants.grayLight, radius: (56*(1-percent)).clamp(20, 56)
                  );
                },
              ),
            )
          ),
          (isOwner&&shrinkOffset<=minExtent)?Positioned(
              bottom: Constants.getScreenHeight(context)*0.006,
              right: (arabic)?Constants.getScreenWidth(context)*0.3:null,
              left: (arabic)?null:Constants.getScreenWidth(context)*0.3,
              child: CircleAvatar(
                backgroundColor: color,
                radius: 22,
                child: CircleAvatar(
                  backgroundColor: (dark)?Constants.primaryColor:Constants.halfGray,
                  radius: 20,
                  child: IconButton(
                    icon: Icon(Icons.add,size: 26,color: Constants.white),
                    onPressed: (){
                      General.buildBottomModelSheet(context: context, isEdit: false, arabic: arabic,dark: dark,
                        uploadImage: true,function1: (){Provider.of<StorePageNotifier>(context,listen: false)
                          .getImgFromPhone(isCamera: true, pProduct: false,context: context,dark: dark,arabic: arabic);},
                        function2: (){Provider.of<StorePageNotifier>(context,listen: false)
                          .getImgFromPhone(isCamera: false, pProduct: false,context: context,dark: dark,arabic: arabic);});
                    },
                  ),
                ),
              )
          ):Positioned(left: 0,child: General.sizeBoxVertical(0.0)),
          (shrinkOffset==maxExtent)?Positioned(
            top: Constants.getScreenHeight(context)*0.01,
            right: (arabic)?Constants.getScreenWidth(context)*0.24:null,
            left: (arabic)?null:Constants.getScreenWidth(context)*0.24,
            child: General.buildTxt(txt: storeOwner.name??"",noTranslate: true,fontSize: 26,color: Constants.whiteTopGrading),
          ):Positioned(top: 0,child: General.sizeBoxVertical(0.0))
        ],
      ),
    );
  }

  @override
  double get maxExtent => Constants.getScreenHeight(context)*0.3;

  @override
  double get minExtent => Constants.getScreenHeight(context)*0.06;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}