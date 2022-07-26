import 'package:agrosnap/Componants/CommonTopOfScreen.dart';
import 'package:agrosnap/Componants/PrimaryContainer.dart';
import 'package:agrosnap/Componants/SearchBar.dart';
import 'package:agrosnap/Models/StoreOwner.dart';
import 'package:agrosnap/Provider/SettingNotifier.dart';
import 'package:agrosnap/Provider/StorePageNotifier.dart';
import 'package:agrosnap/Screens/Stores/StorePage/StorePage.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowStores extends StatefulWidget{
  @override
  State<ShowStores> createState() => _ShowStoresState();
}

class _ShowStoresState extends State<ShowStores> {
  bool dark = false, arabic = false;
  @override
  void initState() {
    var setting = Provider.of<SettingNotifier>(context,listen: false);
    dark = setting.dark;
    arabic = setting.getArLanguage;
    Provider.of<StorePageNotifier>(context,listen: false).getAllStores(dark: dark,arabic: setting.getArLanguage);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: CommonTopOfScreen(
            img: "Assets/wheat.png",txt: "المتاجر",
            height: Constants.getScreenHeight(context)*0.14,
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              left: Constants.getScreenWidth(context)*0.026,
              right: Constants.getScreenWidth(context)*0.026,
              top: Constants.getScreenHeight(context)*0.016
          ),
          margin: EdgeInsets.only(top: Constants.getScreenHeight(context)*0.11),
          decoration: BoxDecoration(
            color: (dark)?Constants.black:Constants.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0),
              topLeft: Radius.circular(40.0),
            ),
          ),
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                title: SearchBar(txt: "بحث عن متاجر", readOnly: false,dark: dark,
                    function: (input){
                      Provider.of<StorePageNotifier>(context,listen: false).getSearchedStores(dark: dark, arabic: arabic, search: input);
                    }
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: Constants.getScreenHeight(context)*0.01),
                sliver: Consumer<StorePageNotifier>(
                  builder: (context,store,child){
                    if(store.loading)
                      return SliverToBoxAdapter(child: Center(child: Padding(
                        padding: EdgeInsets.only(top: Constants.getScreenHeight(context)*0.24),
                        child: General.customLoading(color: (dark)?Constants.darkLoop:Constants.primaryColor,isCircle: true)),)
                      );
                    return SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        delegate: SliverChildBuilderDelegate(
                              (context,index){
                            return PrimaryContainer(
                              titleColor: (dark)?Constants.white:Constants.primaryColor, dark: dark,
                              img: store.stores[index].img??"", title: store.stores[index].name??"",
                              function: (){
                                StoreOwner _store = StoreOwner(id: store.stores[index].id,name: store.stores[index].name,img: store.stores[index].img,phoneNumber: "");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                        StorePage(arabic: arabic, isOwner: false, dark: dark, store: _store)
                                  ),
                                );
                              },
                            );
                          },
                          childCount: store.stores.length,
                        )
                    );
                  },
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}