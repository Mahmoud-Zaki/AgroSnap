import 'package:agrosnap/Componants/PrimaryContainer.dart';
import 'package:agrosnap/Componants/SearchBar.dart';
import 'package:agrosnap/Provider/PlantNotifier.dart';
import 'package:agrosnap/Screens/Plant/Plant.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchByName extends StatefulWidget{
  bool arabic,dark;
  SearchByName({required this.arabic,required this.dark});

  @override
  State<SearchByName> createState() => _SearchByNameState();
}

class _SearchByNameState extends State<SearchByName> {
  @override
  void initState() {
    Provider.of<PlantNotifier>(context,listen: false).getAllPlants(dark: widget.dark,arabic: widget.arabic);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: (widget.dark)?Constants.black:null,
        body: Directionality(
          textDirection: (widget.arabic) ? TextDirection.rtl : TextDirection.ltr,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                    horizontal: Constants.getScreenWidth(context)*0.03,
                    vertical: Constants.getScreenHeight(context)*0.03
                ),
                sliver: SliverAppBar(
                  floating: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: (widget.dark)?Constants.whiteTopGrading:Constants.grayLight,
                  ),
                  title: SearchBar(txt: "بحث عن النباتات", readOnly: false,dark: widget.dark,
                    function: (input){
                      Provider.of<PlantNotifier>(context,listen: false).getSearchedPlants(dark: widget.dark, arabic: widget.arabic, search: input);
                    }
                  ),
                ),
              ),
              SliverPadding(
                  padding: EdgeInsets.only(top: Constants.getScreenHeight(context)*0.01),
                  sliver: Consumer<PlantNotifier>(
                    builder: (context,plant,child){
                      if(plant.loading)
                        return SliverToBoxAdapter(child: Center(child: Padding(
                            padding: EdgeInsets.only(top: Constants.getScreenHeight(context)*0.24),
                            child: General.customLoading(color: (widget.dark)?Constants.darkLoop:Constants.primaryColor,isCircle: true)),)
                        );
                      return SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          delegate: SliverChildBuilderDelegate(
                                (context,index){
                              return PrimaryContainer(
                                titleColor: (widget.dark)?Constants.white:Constants.primaryColor, dark: widget.dark,
                                img: plant.plants[index].img??"", title: plant.plants[index].name??"",
                                function: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      Plant(arabic: widget.arabic,dark: widget.dark,disease: false,id: plant.plants[index].id??"",name: plant.plants[index].name??"")));
                                },
                              );
                            },
                            childCount: plant.plants.length,
                          )
                      );
                    },
                  )
              ),
            ],
          ),
        ),
      )
    );
  }
}