import 'package:agrosnap/Models/PlantInformation.dart';
import 'package:agrosnap/Services/API.dart';
import 'package:agrosnap/Services/OtherServices.dart';
import 'package:agrosnap/Utils/General.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchNotifier extends ChangeNotifier {
  List<PlantInfo> recommended = [];
  bool loading = true;
  String mType = "";
  bool notFound = false;
  bool disease = false;
  var plant;

  void getImgFromPhone({required bool isCamera,required bool dark,required bool arabic,required String type}) async{
    String img = await OtherServices.getImgFromPhone(isCamera: isCamera, base64: true);
    final response;
    if(type=="d"){
      disease = true;
      response = await API.disease(img: img);
    }
    else if(type=="h")
      response = await API.healthy(img: img);
    else
      response = await API.fruits(img: img);

    if(response == false || response == null)
      General.buildToast(msg: (arabic)?"تحقق من اتصالك بالإنترنت":"check your internet connection", dark: dark);
    else if(response=="Not Found")
      notFound = true;
    else
      plant = response;
    mType = type;
    loading = false;
    notifyListeners();
  }
}