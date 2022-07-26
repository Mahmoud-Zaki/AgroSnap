import 'package:flutter/foundation.dart';

class NavigationNotifier extends ChangeNotifier{
  int index = 0;
  bool blur = false;

  int get getIndex => index;
  bool get getBlur => blur;

  void setPageIndex({required int value}){
    index = value;
    blur = false;
    notifyListeners();
  }

  void setBlur(){
    blur =! blur;
    notifyListeners();
  }
}