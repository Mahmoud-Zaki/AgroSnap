import 'package:agrosnap/Componants/CustomStoreHeaderDelegate.dart';
import 'package:agrosnap/Componants/ProductContainer.dart';
import 'package:agrosnap/Models/StoreOwner.dart';
import 'package:agrosnap/Provider/StorePageNotifier.dart';
import 'package:agrosnap/Screens/Home/Home.dart';
import 'package:agrosnap/Screens/Stores/StorePage/Map.dart';
import 'package:agrosnap/Services/PositionOnMap.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StorePage extends StatefulWidget {
  bool arabic,isOwner,dark,recommended;
  StoreOwner store;

  StorePage({required this.arabic,required this.isOwner,required this.dark,required this.store,this.recommended=false});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> with SingleTickerProviderStateMixin{
  TabController? _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    if(!widget.isOwner)
      Provider.of<StorePageNotifier>(context,listen: false).getStore(id: widget.store.id??"", name: widget.store.name??"",img: widget.store.img,arabic: widget.arabic,dark: widget.dark);
    else
      Provider.of<StorePageNotifier>(context,listen: false).setMyStore(myStore: widget.store, arabic: widget.arabic,dark: widget.dark);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async{
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Directionality(textDirection: (widget.arabic)?TextDirection.rtl:TextDirection.ltr, child: Home(dark: widget.dark)),
            ),
                (route) => false,
          );
          return false;
        },
        child: Scaffold(
          backgroundColor: (widget.dark)?Constants.black:null,
          body: Directionality(
            textDirection: (widget.arabic)?TextDirection.rtl:TextDirection.ltr,
            child: Consumer<StorePageNotifier>(
              builder: (context,store,child){
                if(store.store.name==""||store.store.name==null)
                  return Center(child: General.customLoading(color: (widget.dark)?Constants.darkLoop:Constants.primaryColor,isCircle: true));
                return CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                        pinned: true,
                        delegate: CustomStoreHeaderDelegate(
                            context:context,dark: widget.dark,storeOwner: store.store,
                            color: (widget.dark)?Constants.black:Theme.of(context).scaffoldBackgroundColor,
                            isOwner: widget.isOwner,arabic: widget.arabic
                        )
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          General.sizeBoxVertical(Constants.getScreenHeight(context)*0.01),
                          General.buildTxt(txt: store.store.name??"",color: (widget.dark)?Constants.darkLoop:Constants.primaryColor,
                              fontSize: 30,noTranslate: true),
                          InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on_rounded,color: (widget.dark)?Constants.grayLight:Constants.halfGray),
                                General.sizeBoxHorizontal(Constants.getScreenWidth(context)*0.04),
                                General.buildTxt(txt: "الموقع",isBold: false,noTranslate: (widget.isOwner)?false:true,
                                    color: (widget.dark)?Constants.grayLight:Constants.halfGray,fontSize: 22),
                              ],
                            ),
                            onTap: () async{
                              if(widget.isOwner){
                                LatLng location;
                                if(store.store.lat==0.0&&store.store.long==0.0)
                                  location = await PositionOnMap.getCurrentPosition();
                                else
                                  location = LatLng(store.store.lat??0.0, store.store.long??0.0);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MapView(initialLatLng: location, user: !widget.isOwner,
                                              initialMarker: false,arabic: widget.arabic,dark: widget.dark)
                                  ),
                                );
                              }
                              else{
                                if(store.store.lat!=0.0&&store.store.long!=0.0){
                                  LatLng location = LatLng(store.store.lat??0.0, store.store.long??0.0);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MapView(initialLatLng: location, user: !widget.isOwner,
                                                initialMarker: false,arabic: widget.arabic,dark: widget.dark)
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: Constants.getScreenWidth(context)*0.36),
                              child: Divider(thickness: 1.5,color: (widget.dark)?Constants.grayLight:Constants.halfGray)
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (store.store.phoneNumber!="")?IconButton(
                                  icon: Icon(Icons.phone,color: (widget.dark)?Constants.darkPhoneColor:Constants.phoneColor),
                                  onPressed: () async{
                                    String url = 'tel:'+store.store.phoneNumber.toString();
                                    if (!await launch(url)) throw 'Could not launch $url';
                                  }
                              ):General.sizeBoxHorizontal(0.0),
                              (store.store.faceLink!="")?IconButton(
                                  icon: Icon(Icons.facebook_rounded,color: (widget.dark)?Constants.darkFacebookColor:Constants.facebookColor),
                                  onPressed: () async{
                                    String url = store.store.faceLink??"";
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  }
                              ):General.sizeBoxHorizontal(0.0),
                              (store.store.anotherLink!="")?IconButton(
                                  icon: Icon(Icons.link,color: (widget.dark)?Constants.grayLight:Constants.halfGray),
                                  onPressed: () async{
                                    String url = store.store.anotherLink??"";
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  }
                              ):General.sizeBoxHorizontal(0.0),
                            ],
                          )
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: TabBar(
                        controller: _tabController,
                        labelColor: (widget.dark)?Constants.darkLoop:Constants.primaryColor,
                        unselectedLabelColor: (widget.dark)?Constants.darkGrayLight:Constants.halfGray,
                        indicatorColor: (widget.dark)?Constants.darkLoop:Constants.primaryColor,
                        automaticIndicatorColorAdjustment: true,
                        indicatorWeight: 2.6,
                        padding: EdgeInsets.only(right: Constants.getScreenWidth(context)*0.2,
                            left: Constants.getScreenWidth(context)*0.2,bottom: Constants.getScreenHeight(context)*0.02),
                        onTap: (int index){
                          Provider.of<StorePageNotifier>(context,listen: false).setIndex(value: index);
                        },
                        tabs: <Widget>[
                          Tab(text: (widget.arabic)?"جميع النباتات":"All Plants"),
                          Tab(text: (widget.arabic)?"الموصى به":"Recommended"),
                        ],
                      ),
                    ),
                    SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        delegate: SliverChildBuilderDelegate(
                              (context,index){
                            if(store.productLoading)
                              return Center(child: General.customLoading(color: (widget.dark)?Constants.darkLoop:Constants.primaryColor,isCircle: true));
                            else{
                              if(store.index==0){
                                if(index==store.products.length){
                                  return ProductContainer(addProduct: true,isOwner: widget.isOwner,
                                      arabic: widget.arabic,dark:widget.dark);}
                                else
                                  return ProductContainer(
                                      product: store.products[index],isOwner: widget.isOwner,
                                      dark: widget.dark, arabic: widget.arabic
                                  );
                              }
                              else
                                return ProductContainer(
                                    product: store.recommendedProduct,
                                    dark: widget.dark, isOwner: false,arabic: widget.arabic
                                );
                            }
                          },
                          childCount: (store.index==0)?(widget.isOwner)?store.products.length+1:store.products.length
                              : (widget.recommended)?1:0,
                        )
                    )
                  ],
                );
              },
            )
          ),
        ),
      )
    );
  }
}