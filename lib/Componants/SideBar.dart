import 'package:agrosnap/Provider/PlantNotifier.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideBar extends StatefulWidget {
  bool dark,disease;
  SideBar({required this.dark,required this.disease});
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool isOpen = false;
  int selectedItem = 0;
  List<String> info = [
    "Assets/overview.png",
    "Assets/plantCare.png",
    "Assets/image3.png",
    "Assets/image4.png",
    "Assets/harvest.png",
    "Assets/image6.png",
    "Assets/image7.png",
    "Assets/image8.png",
    "Assets/image9.png",
    "Assets/seed.png",
    "Assets/image11.png",
    "Assets/image12.png"
  ];

  List<String> disease = [
    "Assets/overview.png",
    "Assets/disease.png",
    "Assets/flask(1).png",
    "Assets/herbal-treatment.png",
    "Assets/save-nature.png",
    "Assets/image8.png",
    "Assets/virus.png"
  ];

  @override
  Widget build(BuildContext context) {
    double width = Constants.getScreenWidth(context);
    double height = Constants.getScreenHeight(context);
    return  Directionality(
      textDirection:TextDirection.ltr,
      child: Row(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
            width: isOpen ? width * 0.25 : width * 0.01,
            height: height ,
            decoration: BoxDecoration(
              color: (widget.dark)?Constants.darkOrange:Constants.orange,
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(15),
                left: Radius.zero,
              ),
            ),
            child: isOpen ? SizedBox(
              height: height,
              child: ListView.builder(
                itemCount: (widget.disease)?disease.length:info.length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {selectedItem = index;});
                              Provider.of<PlantNotifier>(context,listen: false).updateIndex(uIndex: selectedItem);
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              child: Image.asset((widget.disease)?disease[index]:info[index],
                                color:  selectedItem==index ? Constants.white:Colors.white54),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 7,
                            width: 7,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:  selectedItem==index ? Constants.white:Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              }),
            ): General.sizeBoxHorizontal(0.0),
          ),
          Align(
            alignment: Alignment(0, 0.7),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isOpen = !isOpen;
                });
              },
              child: ClipPath(
                clipper: CustomMenuClipper(),
                child: Container(
                  width: 30,
                  height: 110,
                  color: (widget.dark)?Constants.darkOrange:Constants.orange,
                  child: Center(
                    child: AnimatedCrossFade(
                      duration: Duration(milliseconds: 250),
                      firstChild: Icon(
                        Icons.arrow_forward_ios,
                        color: Constants.white,
                      ),
                      secondChild: Icon(
                        Icons.arrow_back_ios,
                        color: Constants.white,
                      ),
                      crossFadeState: !isOpen
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Constants.white;
    final width = size.width;
    final height = size.height;
    Path path = Path();
    path.moveTo(0,0);
    path.quadraticBezierTo(0,8,10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}