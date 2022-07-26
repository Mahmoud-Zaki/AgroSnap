import 'package:agrosnap/Componants/CirclesList.dart';
import 'package:agrosnap/Componants/PrimaryContainer.dart';
import 'package:agrosnap/Componants/SideBar.dart';
import 'package:agrosnap/Models/StoreOwner.dart';
import 'package:agrosnap/Provider/PlantNotifier.dart';
import 'package:agrosnap/Provider/RemindersNotififier.dart';
import 'package:agrosnap/Provider/SearchNotifier.dart';
import 'package:agrosnap/Screens/Stores/StorePage/StorePage.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Plant extends StatefulWidget{
  String? id,name;
  bool arabic,disease,dark,recommend;
  Plant({this.id,this.name,required this.disease,required this.dark,required this.arabic,this.recommend = false});

  @override
  State<Plant> createState() => _PlantState();
}

class _PlantState extends State<Plant> {
  @override
  void initState() {
    var plant = Provider.of<SearchNotifier>(context,listen: false).plant;
    if(widget.recommend){
      Provider.of<PlantNotifier>(context,listen: false).setPlant(recommendedPlant: plant);
    } else {
      Provider.of<PlantNotifier>(context,listen: false).getPlantInfo(id: widget.id!, dark: widget.dark, arabic: widget.arabic);
    }
    Provider.of<PlantNotifier>(context,listen: false).getStoresWithPlant(dark: widget.dark, arabic: widget.arabic, name: widget.name??"");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = Constants.getScreenWidth(context);
    double height = Constants.getScreenHeight(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: (widget.dark)?Constants.black:null,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Consumer<PlantNotifier>(
              builder: (context,plant,child){
                if(plant.loading || plant.plant==null)
                  return Padding(
                    padding: EdgeInsets.only(top: height*0.46),
                    child: Center(child: General.customLoading(color: (widget.dark)?Constants.darkLoop:Constants.primaryColor,isCircle: true)),
                  );
                else
                  return Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: Container(
                          height: height * 0.4,
                          width: width,
                          decoration: BoxDecoration(
                            color: Constants.petrolColor,
                            image: DecorationImage(
                                image: AssetImage("Assets/polygon.png"),fit: BoxFit.cover,
                                alignment: Alignment.topLeft
                            ),
                          ),
                        ),
                      ),
                      Container(
                          width: width,
                          margin: EdgeInsets.only(top: height * 0.34),
                          padding: EdgeInsets.only(bottom: height * 0.04),
                          decoration: BoxDecoration(
                            color: (widget.dark)?Constants.black:Constants.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              General.sizeBoxVertical(height * 0.08),
                              (!widget.disease&&plant.index==0)?General.buildTxt(txt: "التصنيف العلمي", fontSize: 26,
                                color: (widget.dark)?Constants.white :Constants.primaryColor, pRight: width*0.05)
                                  : General.sizeBoxVertical(0.0),
                              General.sizeBoxVertical(height * 0.01),
                              (!widget.disease&&plant.index==0)?Selector<PlantNotifier,bool>(
                                selector: (context,bagOfIndex)=>bagOfIndex.getEmptyBagOfIndex,
                                builder: (context,empty,child){
                                  return SizedBox(
                                    height: (empty)?height * 0.1:height * 0.16,
                                    child: ListView.builder(
                                        padding: EdgeInsets.symmetric(horizontal: width*0.05),
                                        itemCount: plant.scientificInfo.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, int index){
                                          return CirclesList(title: plant.scientificInfo[index],body: plant.plant[plant.scientificInfo[index]]??"",
                                              function: (){plant.setBagOfIndex(index: index);});
                                        }
                                    ),
                                  );
                                },
                              ):General.sizeBoxVertical(0.0),
                              General.buildTxt(txt: (widget.disease)?plant.disease[plant.index]:plant.info[plant.index],fontSize: 26,color: (widget.dark)?Constants.white
                                :Constants.primaryColor,pRight: width*0.05),
                              General.buildTxt(txt: (!widget.disease&&plant.index==5)?"مواعيد الري":(widget.disease)?plant.plant[plant.disease[plant.index]]??"":plant.plant[plant.info[plant.index]]??"",
                                color: (widget.dark)?(!widget.disease&&plant.index==5)?Constants.white:Constants.grayLight:Constants.primaryColor,pRight: width*0.05,pLeft: width*0.01,
                                fontSize: (!widget.disease&&plant.index==5)?26:20
                              ),
                              (!widget.disease&&plant.index==5)?General.buildTxt(txt: plant.plant["مواعيد الري"]??"",
                                  color: (widget.dark)?Constants.grayLight:Constants.primaryColor,pRight: width*0.05,pLeft: width*0.01,
                              ):General.sizeBoxVertical(0.0),
                              (!widget.disease&&plant.index==5)?General.sizeBoxVertical(width*0.04):General.sizeBoxVertical(0.0),
                              (!widget.disease&&plant.index==5)?General.buildTxt(txt: "طرق الري",fontSize: 26,
                                color: (widget.dark)?Constants.white:Constants.primaryColor,pRight: width*0.05,pLeft: width*0.01,
                              ):General.sizeBoxVertical(0.0),
                              (!widget.disease&&plant.index==5)?General.buildTxt(txt: plant.plant["طرق الري"]??"",
                                color: (widget.dark)?Constants.grayLight:Constants.primaryColor,pRight: width*0.05,pLeft: width*0.01,
                              ):General.sizeBoxVertical(0.0),
                              (!widget.disease&&plant.index==5)?General.sizeBoxVertical(Constants.getScreenHeight(context)*0.04):General.sizeBoxVertical(0.0),
                              (!widget.disease&&plant.index==5)?General.buildTxt(txt: "كميات الري",fontSize: 26,
                                color: (widget.dark)?Constants.white:Constants.primaryColor,pRight: width*0.05,pLeft: width*0.01,
                              ):General.sizeBoxVertical(0.0),
                              (!widget.disease&&plant.index==5)?General.buildTxt(txt: plant.plant["كميات الري"]??"",
                                color: (widget.dark)?Constants.grayLight:Constants.primaryColor,pRight: width*0.05,pLeft: width*0.01,
                              ):General.sizeBoxVertical(0.0),
                              General.sizeBoxVertical(height*0.06),
                              SizedBox(
                                height: height * 0.26,
                                child: ListView.builder(
                                    padding: EdgeInsets.symmetric(horizontal: width*0.03),
                                    itemCount: plant.stores.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, int index){
                                      return PrimaryContainer(
                                        titleColor: (widget.dark)?Constants.white:Constants.primaryColor, dark: widget.dark,
                                        img: plant.stores[index].img??"", title: plant.stores[index].name??"",
                                        function: (){
                                           StoreOwner _store = StoreOwner(id: plant.stores[index].id,name: plant.stores[index].name,
                                               img: plant.stores[index].img,phoneNumber: "");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StorePage(arabic: widget.arabic, isOwner: false, dark: widget.dark, store: _store)
                                            ),
                                          );
                                        },
                                      );
                                    }
                                ),
                              )
                            ],
                          )
                      ),
                      Positioned(
                          top: height * 0.04,
                          right: width * 0.05,
                          child: General.buildTxt(txt: (widget.disease)?plant.plant["اسم المرض"]??"":plant.plant["الاسم"]??"",color: Constants.white,fontSize: 30,noTranslate: true)
                      ),
                      (!widget.disease)?Positioned(
                        top: height * 0.16,
                        left: width * 0.56,
                        child: SizedBox(
                          height: height * 0.15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(CupertinoIcons.sun_max, color: Constants.white),
                                  General.sizeBoxHorizontal(width*0.05),
                                  General.buildTxt(txt: plant.plant["الشمس"].toString(),noTranslate: true,color: Constants.white)
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(CupertinoIcons.drop, color: Constants.white),
                                  General.sizeBoxHorizontal(width*0.05),
                                  General.buildTxt(txt: plant.plant["عدد مرات الري"].toString(),noTranslate: true,color: Constants.white)
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("Assets/heat.png",color: Constants.white,width: 26,height: 26),
                                  General.sizeBoxHorizontal(width*0.05),
                                  General.buildTxt(txt: plant.plant["درجة الحرارة"].toString(),noTranslate: true,color: Constants.white)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ):General.sizeBoxVertical(0.0),
                      (!widget.disease)?Positioned(
                        top: height * 0.34,
                        right: 0,
                        child: SizedBox(
                          width: width * 0.35,
                          height: height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              Provider.of<RemindersNotifier>(context,listen: false).addAutoPlant(uName: widget.name??"");
                              General.buildToast(msg: (widget.arabic)?"تمت الإضافة بنجاح":"Added successfully", dark: widget.dark);
                            },
                            child: General.buildTxt(txt: "أضف إلى الرعاية",color: Constants.white,noTranslate: true),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all((widget.dark)?Constants.darkOrange:Constants.orange),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  ),
                                ),
                              ),
                              shadowColor: MaterialStateProperty.all(Constants.orange.withOpacity(0.5)),
                              elevation: MaterialStateProperty.all(4),
                            ),
                          ),
                        ),
                      ):General.sizeBoxVertical(0.0),
                      Positioned(
                        top: height * 0.09,
                        left: width * 0.06,
                        child: Container(
                          width: width * 0.41,
                          height: height * 0.32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Constants.grayLight,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider((widget.disease)?plant.plant["صورة"]??"":plant.plant["الصورة"]??""),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SideBar(dark:widget.dark,disease: widget.disease),
                    ],
                  );
              },
            )
          ),
        ),
      ),
    );
  }
}