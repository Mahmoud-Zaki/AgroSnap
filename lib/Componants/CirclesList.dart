import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';

class CirclesList extends StatefulWidget {
  String title,body;
  Function function;
  CirclesList({required this.title,required this.body,required this.function});

  @override
  _CirclesListState createState() => _CirclesListState();
}

class _CirclesListState extends State<CirclesList> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          height: isOpen ? 120 : 64,
          width: isOpen ? 75 : 64,
          decoration: ShapeDecoration(
            shape: StadiumBorder(),
            color: Constants.halfBlue,
          ),
          margin: isOpen
              ? EdgeInsets.only(top: 0, right: 0,left: 0)
              : EdgeInsets.only(top: 5, right: 6, left: 0),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
            widget.function();
          },
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 5, top: 5),
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: isOpen ? Constants.white : Constants.halfBlue,
              shape: BoxShape.circle,
            ),
            child: Align(alignment: Alignment.center,child: General.buildTxt(txt: widget.title,color: Constants.primaryColor,noTranslate: true,fontSize: 17)),
          ),
        ),
        Positioned(
          top: 75,
          right: 19,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 100),
            opacity: isOpen ? 1 : 0,
            child: Align(alignment: Alignment.center,child: General.buildTxt(txt: widget.body,color: Constants.primaryColor,noTranslate: true,fontSize: 15))
          ),
        ),
      ],
    );
  }
}