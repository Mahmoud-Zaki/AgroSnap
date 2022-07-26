import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomAppBarDelegate extends SliverPersistentHeaderDelegate {
  final String title,img;
  final context;

  CustomAppBarDelegate({required this.context,required this.title, required this.img});

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        //color: Constants.white,
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(20.0),
            bottomRight: const Radius.circular(20.0),
          ),
        image: DecorationImage(
          image: CachedNetworkImageProvider(img),
          fit: BoxFit.cover,
        )
      ),
      child: Center(
        child: General.buildTxt(
          txt:(shrinkOffset==Constants.getScreenHeight(context)*0.3)?title:"", noTranslate: true,
        ),
      ),
    );
  }

  @override
  double get maxExtent => Constants.getScreenHeight(context)*0.34;

  @override
  double get minExtent => Constants.getScreenHeight(context)*0.1;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}