import 'package:agrosnap/Models/Product.dart';
import 'package:agrosnap/Provider/StorePageNotifier.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductContainer extends StatelessWidget{
  Product? product;
  bool addProduct,isOwner,arabic,dark;
  ProductContainer({this.product,required this.dark,
    this.addProduct=false, this.isOwner=false,required this.arabic});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Directionality(
        textDirection: (arabic)?TextDirection.rtl:TextDirection.ltr,
        child: Container(
          width: Constants.getScreenWidth(context)*0.46,
          margin: const EdgeInsets.only(left: 16,right: 10,top: 4,bottom: 10),
          decoration: BoxDecoration(
            color: (dark)?Constants.darkBlueLight:(isOwner&&addProduct)?Constants.whiteTopGrading:Constants.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Constants.blueGray.withOpacity(0.5),
                blurRadius: 4,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: (addProduct)?MainAxisAlignment.center:MainAxisAlignment.start,
            children: (addProduct)?
            [
              CircleAvatar(
                backgroundColor: Constants.halfGray,
                radius: 24,
                child: Icon(Icons.add,size: 34,color: Constants.white),
              ),
              General.sizeBoxVertical(Constants.getScreenHeight(context)*0.01),
              General.buildTxt(txt: "إضافة نبات جديد",color: (dark)?Constants.whiteTopGrading:Constants.gray)
            ] : [
              Container(
                height: Constants.getScreenHeight(context)*0.16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(product!.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constants.getScreenWidth(context)*0.016),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: General.buildTxt(txt: product!.name,color: (dark)?Constants.whiteTopGrading:Constants.gray,noTranslate: true)),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Constants.blue,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Constants.blue.withOpacity(0.5),
                                blurRadius: 6,
                                offset: Offset(0, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          child: CircleAvatar(child: General.buildTxt(txt: product!.price.toString(),noTranslate: true,
                              color: Constants.white), backgroundColor: Constants.blue)
                        )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: (isOwner&&addProduct)?(){
        General.buildBottomModelSheet(context: context,isEdit: false,arabic: arabic,dark: dark);
      }:null,
      onLongPress: (isOwner&&!addProduct)?(){
        Provider.of<StorePageNotifier>(context,listen: false).setProduct(pProduct: product!);
        General.buildBottomModelSheet(context: context,isEdit: true,arabic: arabic,dark: dark,name:product!.name,price:product!.price.toString());
      }:null,
    );
  }
}