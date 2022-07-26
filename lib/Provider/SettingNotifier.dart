import 'package:agrosnap/Services/SharedPreference.dart';
import 'package:flutter/foundation.dart';

class SettingNotifier extends ChangeNotifier{
  bool dark = false;
  bool largeFontSize = false;
  bool arabicLanguage = true;
  bool appearSize = false;
  bool appearLanguage = false;
  int groupSizeValue = 0;
  int groupLanguageValue = 2;

  bool get getArLanguage => arabicLanguage;

  void setDarkMode({required bool value}){
    dark = value;
    notifyListeners();
  }

  void setFontSize({required value}){
    groupSizeValue = value;
    if(value == 0)
      largeFontSize = false;
    else //1
      largeFontSize = true;
    notifyListeners();
  }

  void setLanguage({required value}){
    groupLanguageValue = value;
    if(value == 2)
      arabicLanguage = true;
    else //3
      arabicLanguage = false;
    notifyListeners();
  }

  void getData() async{
    int lang = await SharedPreferenceHandler.getLanguage()??2;
    setLanguage(value: lang);
    bool mode = await SharedPreferenceHandler.getMode()??false;
    setDarkMode(value: mode);
    int size = await SharedPreferenceHandler.getFontSize()??0;
    setFontSize(value: size);
  }

  void openSize(){
    appearSize = !appearSize;
    notifyListeners();
  }

  void openLanguage(){
    appearLanguage = !appearLanguage;
    notifyListeners();
  }
}